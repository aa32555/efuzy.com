<template>
  <q-card ref="fcContainer" style="height:100%;width:100%">
    <div id="appToolbar">
      <p class="text-h3 text-center print-only">Schedule</p>
      <q-page-sticky
        expand
        position="top"
        :offset="[0, 0]"
        :style="'z-index:2;'"
        class="print-hide"
      >
        <q-bar
          v-touch-swipe="handleSwip"
          :class="
            !$q.dark.isActive
              ? 'bg-blue-grey-1 text-black col print-hide'
              : ' text-white col print-hide'
          "
          :style="
            $q.dark.isActive
              ? 'background: #121212;width:100%;height:40px;'
              : 'width:100%;height:40px'
          "
        >
          <FUZIcon
            path="SiriLoading"
            :width="$q.screen.lt.sm ? 150 : 800"
            :height="$q.screen.lt.sm ? 150 : 800"
            v-if="false"
            :loop="true"
            class="fixed absolute-center z-max"
          />
          <div :class="'flex full-width justify-between'+($q.screen.gt.xs?'  items-start content-start':'')">
          <span class="text-weight-bold text-h6">
            {{ viewLabel }}
          </span>
          <div class="text-center text-weight-bold">
            <q-btn
              :size="$q.screen.gt.xs ? '18px' : '15px'"
              :disable="ajaxStatus"
              dense
              flat
              rounded
              icon="calendar_today"
              @click="goToday"
            />
            <q-btn
              :disable="ajaxStatus"
              dense
              v-if="$q.screen.gt.xs"
              :size="$q.screen.gt.xs ? '18px' : '15px'"
              flat
              rounded
              icon="skip_previous"
              @click="goPrev"
            />

            <q-btn
              :disable="ajaxStatus"
              :size="$q.screen.gt.xs ? '18px' : '15px'"

              rounded
              flat
              dense
              :label="headerText"
              @click="gotoDateDialog = true"
            />
            <q-btn
              :disable="ajaxStatus"
              dense
              :size="$q.screen.gt.xs ? '18px' : '15px'"
              flat
              rounded
              icon="skip_next"
              v-if="$q.screen.gt.xs"
              @click="goNext"
            />
            <q-btn
              :size="$q.screen.gt.xs ? '18px' : '15px'"
              :disable="ajaxStatus"
              dense
              flat
              rounded
              icon="print"
              v-if="$q.screen.gt.xs"
              @click="printCalendar"
            />
                        <q-btn
              :size="$q.screen.gt.xs ? '18px' : '15px'"
              :disable="ajaxStatus"
              dense
              flat
              rounded
              icon="settings"
              @click="printCalendar"
            />
          </div>
          <div>
<q-btn-dropdown
              dense
              flat
              rounded
              no-icon-animation
              :label="$q.screen.gt.xs ? 'View' : ''"
              dropdown-icon="view_list"
              :size="$q.screen.gt.xs ? '18px' : '15px'"
              :disable="ajaxStatus"
              class="float-right"
            >
              <q-list bordered padding>
                 <q-item-label header>View Frequency</q-item-label>
                <q-item>
                  <q-item-section>
                    <q-radio
                      v-model="viewFrequency"
                      :val="'Day:Daily'"
                      label="Daily"
                    />
                    <q-radio
                      v-model="viewFrequency"
                      :val="'Week:Weekly'"
                      label="Weekly"
                    />
                    <q-radio
                      v-model="viewFrequency"
                      :val="'Month:Monthly'"
                      label="Monthly"
                    />
                  </q-item-section>
                </q-item>
                <q-separator />
                <q-item-label header>View Type</q-item-label>
                <q-item>

                  <q-item-section>
                    <q-radio
                      v-model="viewType"
                      :val="'resourceTimeGrid:Stylists'"
                      label="Stylists expanded view"
                    />
                    <q-radio
                      v-model="viewType"
                      :val="'timeGrid:Stylists Combined'"
                      label="Stylists combined view"
                    />
                    <q-radio
                      v-model="viewType"
                      :val="'list:List'"
                      label="List view"
                    />
                  </q-item-section>
                </q-item>
                                <q-separator />
                                <q-item-label header>Stylists</q-item-label>
                <q-item>
                  <q-item-section>
      <q-radio @input="rerenderCalendar" v-model="staffSelectedForView" val="all" label="All Stylists" />
      <q-radio @input="rerenderCalendar" v-model="staffSelectedForView" val="working" label="Working Stylists" />
      <q-radio @input="viewStaff = [];$q.localStorage.set('CALENDAR:viewStaff','selected')" v-model="staffSelectedForView" val="selected" label="Selected Stylists" />
              </q-item-section>

              </q-item>
              <div v-if="staffSelectedForView === 'selected'">
                <q-item
                  tag="label" v-ripple clickable
                  v-for="staff in bookingStaffList"
                  :key="'staff-' + staff.id"
                >
                <q-item-section>
                    <div v-if="typeof staff.image === 'object'">
                      <img :src="staff.image.join('')" class="avatar" />
                    </div>
                    <div
                      v-if="typeof staff.image !== 'object'"
                      style="padding-top:5px;"
                      class="vertical-middle"
                    >
                      <div
                        :style="
                          'padding:7px;background-color:' +
                            staff.color +
                            ';color:' +
                            staff.fontColor
                        "
                        :class="'text-center avatar text-h5 vertical-middle'"
                      >
                        {{ staff.name.toUpperCase()[0] }}
                      </div>
                    </div>
                  </q-item-section>
                  <q-item-section>
                    <q-item-label>{{ staff.name }}</q-item-label>
                  </q-item-section>
                  <q-item-section side top>
                    <q-checkbox @input="rerenderCalendar" v-model="viewStaff" :val="staff.id" />
                  </q-item-section>
                </q-item>
                </div>
                <q-separator spaced />
              <q-item tag="label" v-ripple clickable>
                <q-item-section>
                <q-item-label>Compress View ?</q-item-label>
                </q-item-section>
                  <q-item-section>
                    <q-radio v-model="fitStaffToScreen" :val="true" :label="'Yes'"/>
                    <q-radio v-model="fitStaffToScreen" :val="false" :label="'No'"/>
                  </q-item-section>
                </q-item>
              </q-list>
            </q-btn-dropdown>
            </div>
          </div>
        </q-bar>
      </q-page-sticky>
      <div
        :style="
          (!print
            ? 'width:100%;'
            : $q.screen.name === 'xs' || $q.screen.name === 'sm'
            ? 'width:100vw'
            : 'width:1100px')"
      >
        <FullCalendar
          ref="fullCalendar"
          :key="calendarKey"
          class="fullcal-full-height"
          :id="$q.dark.isActive ? 'fullCalendarDark' : 'fullCalendarLight'"
          :options="calendarOptions"
        />
      </div>
      <q-btn
        size="xs"
        dense
        flat
        rounded
        color="q-dark"
        class="z-top"
        v-show="selectButtonShown"
        :style="
          'position:absolute;top:' +
            selectButtonPositionY +
            'px;left:' +
            selectButtonPositionX +
            'px;'
        "
      >
        <q-popup-proxy ref="selectButton" @hide="selectButtonShown = false">
          <q-list bordered separator class="bg-primary text-white">
            <q-item-label header class="bg-warning text-black"
              >{{
                selectEvent.resource && selectEvent.resource.id !== "0"
                  ? selectEvent.resource.title + " - "
                  : ""
              }}
              {{
                selectEvent.start
                  ? moment(selectEvent.start).format("LLLL")
                  : ""
              }}</q-item-label
            >
            <q-item clickable v-ripple @click="bookNewAppt(selectEvent)">
              <q-item-section
                >Book an appointment
                {{
                  selectEvent.resource && selectEvent.resource.id !== "0"
                    ? "for " + selectEvent.resource.title
                    : ""
                }}</q-item-section
              >
            </q-item>
            <q-item
              clickable
              v-ripple
              @click="$refs.selectStylistBlockDialog.show()"
            >
              <q-item-section
                >Add blocked time
                {{
                  selectEvent.resource && selectEvent.resource.id !== "0"
                    ? "for " + selectEvent.resource.title
                    : ""
                }}</q-item-section
              >
            </q-item>
            <q-item clickable v-ripple @click="addworkingHours(selectEvent)">
              <q-item-section
                >Add working hours
                {{
                  selectEvent.resource && selectEvent.resource.id !== "0"
                    ? "for " + selectEvent.resource.title
                    : ""
                }}</q-item-section
              >
            </q-item>
            <q-item
              clickable
              v-ripple
              @click="$refs.selectStylistForWorkingHoursDialog.show()"
              v-if="
                selectEvent &&
                  selectEvent.resource &&
                  selectEvent.resource.id !== '0'
              "
            >
              <q-item-section
                >Add working hours for another stylist</q-item-section
              >
            </q-item>

          </q-list>
        </q-popup-proxy>
      </q-btn>
    </div>
    <q-dialog
      v-model="popper"
      seamless
      :position="$q.platform.is.mobile ? 'bottom' : 'bottom'"
    >
      <appointment-card
        :currentEvent="currentEvent"
        style="width:400px"
        @dismiss="
          persist = false;
          popper = false;
        "
        @park="parkAppointment"
        @edit="editAppointment"
        :apptID="currentApptID"
        :key="apptCardKey"
        :persist="persist"
        @refetchEvents="refetchEvents"
      />
    </q-dialog>
    <q-dialog v-model="gotoDateDialog">
      <q-card>
        <q-card-section class="row items-center q-pb-none">
          <div class="text-h6">Goto Date</div>
          <q-space />
          <q-btn icon="close" flat round dense v-close-popup />
        </q-card-section>

        <q-card-section>
          <q-date
            v-model="gotoDate"
            today-btn
            :landscape="$q.screen.gt.xs"
            mask="MM-DD-YYYY"
          />
        </q-card-section>
        <q-card-section>
          <q-btn label="Cancel" color="primary" flat v-close-popup />
          <q-btn
            label="OK"
            color="primary"
            flat
            @click="gotoDateCalendar"
            v-close-popup
          />
        </q-card-section>
      </q-card>
    </q-dialog>
    <appointment-card
      :currentEvent="currentEvent"
      ref="apptCard"
      class="tooltip"
      style="width:400px"
      v-if="modalShown"
      @dismiss="
        persist = false;
        popper = false;
      "
      @park="parkAppointment"
      @edit="editAppointment"
      :apptID="currentApptID"
      :key="apptCardKey"
      :persist="persist"
      @refetchEvents="refetchEvents"
    />
    <q-dialog
      ref="selectStylistForWorkingHoursDialog"
      @hide="onSelectStylistForWorkingHoursDialogHide"
      persistent
    >
      <q-card>
        <q-card-actions>
          <FUZListSearch
            :type="'STAFF'"
            :routine="'List^STAFF'"
            :selectItems="{
              avatar: 'image',
              label: 'name',
              caption: ['description']
            }"
            v-model="selectedStaffForWorkingHours"
            :label="'Search Stylists'"
          />
        </q-card-actions>
        <q-card-actions align="right">
          <q-btn color="primary" label="OK" @click="setStaffAndWorkingHours" />
          <q-btn
            color="primary"
            label="Cancel"
            @click="$refs.selectStylistForWorkingHoursDialog.hide()"
          />
        </q-card-actions>
      </q-card>
    </q-dialog>
    <q-dialog
      ref="selectStylistBlockDialog"
      @hide="onSelectStylistBlockDialogHide"
      persistent
    >
      <q-card>
        <q-card-section>
          <div
            class="flex flex-center"
            :style="
              'width:350px;background-color:' +
                blockColor +
                ';color:' +
                blockFontColor
            "
          >
            <div class="row float-left" style="font-size:16px">
              Select a block time color
            </div>
            <div class="row">
              <div class="col">
                <ColorPicker v-model="blockColor" />
              </div>
            </div>
          </div>
        </q-card-section>
        <q-card-section
          ><div class="row">
            <q-input
              rounded
              outlined
              v-model="blockDescription"
              label="Description"
              style="width:350px"
            />
          </div>
        </q-card-section>
        <q-card-section
          ><div class="row">
            <q-select
              rounded
              outlined
              v-model="blockFontColor"
              label="Text color"
              style="width:350px"
              :behavior="$q.screen.lt.md === true ? 'dialog' : 'menu'"
              :options="['white', 'black']"
            />
          </div>
        </q-card-section>
        <q-card-actions align="right">
          <q-btn color="primary" label="OK" @click="setStaffBlockHours" />
          <q-btn
            color="primary"
            label="Cancel"
            @click="$refs.selectStylistBlockDialog.hide()"
          />
        </q-card-actions>
      </q-card>
    </q-dialog>
    <NewApptModal ref="newApptModal" :event="newEvent" v-if="newEvent" :key="newApptKey" @apptBooked="refetchEvents"/>
    <div v-if="false">
      <FUZDialog />
    </div>
  </q-card>
</template>
<script>
import '@fullcalendar/common/main.css'
import '@fullcalendar/timegrid/main.css'
import '@fullcalendar/timeline/main.css'
import '@fullcalendar/resource-timeline/main.css'
import '@fullcalendar/list/main.css'
import FullCalendar from '@fullcalendar/vue'
import resourceDayGridPlugin from '@fullcalendar/resource-daygrid'
// import bootstrapPlugin from '@fullcalendar/bootstrap'
import resourceTimeGridPlugin from '@fullcalendar/resource-timegrid'
import interactionPlugin from '@fullcalendar/interaction'
import dayGridPlugin from '@fullcalendar/daygrid'
import resourceTimelinePlugin from '@fullcalendar/resource-timeline'
import listPlugin from '@fullcalendar/list'
import appointmentCard from '../../components/appointmentCard'
import { uid } from 'quasar'
import moment from 'moment'
import { createPopper } from '@popperjs/core'
import FUZListSearch from '../../components/FUZListSearch'
import FUZIcon from '../../components/FUZIcon'
import FUZDialog from '../../components/FUZDialog'
import scrollgrid from '@fullcalendar/scrollgrid'
import $ from 'jquery'
import FUZColorPicker from '../../components/FUZColorPicker'
import adaptivePlugin from '@fullcalendar/adaptive'
import CardMaker from './CardMaker'
import NewApptModal from './NewApptModal'

export default {
  data () {
    const self = this
    return {
      newEvent: null,
      calendarKey: uid(),
      calendarOptions: {
        slotDuration: '00:10:00',
        slotLabelInterval: '00:10:00',
        expandRows: false,
        refetchResourcesOnNavigate: true,
        height: 0,
        schedulerLicenseKey: '0355175304-fcs-1574477250',
        plugins: [
          resourceTimeGridPlugin,
          interactionPlugin,
          dayGridPlugin,
          resourceTimelinePlugin,
          listPlugin,
          scrollgrid,
          resourceDayGridPlugin,
          adaptivePlugin
        ],
        loading: function (isLoading) {
          self.ajaxStatus = isLoading
        },
        resourceOrder: 'order',
        resources: async function (fetchInfo, successCallback, failureCallback) {
          try {
            const data = await self.$M('GetResources^CALENDAR', {
              fetchInfo,
              print: self.print,
              staffSelectedForView: self.staffSelectedForView,
              viewStaff: self.viewStaff
            })
            self.currentResourcesInView = data.data.resources.map(
              res => res.id
            )
            successCallback(data.data.resources)
          } catch (e) {
            failureCallback()
          }
        },
        events: async function (info, successCallback, failureCallback) {
          /*
          const resources = self.bookingStaffList.map(s => s.id)
          var bgEvents = []
          var timeCursor = moment(info.start)
          while (+timeCursor < +moment(info.end)) {
            var start = +timeCursor
            timeCursor = timeCursor.add(15, 'minutes')
            var end = +timeCursor
            resources.map((res) => {
              bgEvents.push({
                start: start,
                end: end,
                resourceId: res,
                display: 'background',
                title: moment(start).format('hh:mm a')
              })
              bgEvents.push({
                start: start,
                end: end,
                display: 'background',
                title: moment(start).format('hh:mm a')
              })
            })
          }
          */

          try {
            const bgEvents = []
            const data = await self.$m('GetEvents^CALENDAR', {
              start: info.start,
              end: info.end,
              print: self.print,
              staffSelectedForView: self.staffSelectedForView,
              viewStaff: self.viewStaff
            })
            let allEvents = []
            if (data && data.data && data.data.events) {
              allEvents = [...data.data.events, ...bgEvents]
            } else {
              allEvents = bgEvents
            }
            successCallback(allEvents)
          } catch (e) {
            failureCallback()
            self.$nextTick(() => {
            })
          }
        },
        initialView:
          typeof self.$q.localStorage.getItem('CALENDAR:initialView') ===
          'string'
            ? self.$q.localStorage.getItem('CALENDAR:initialView')
            : 'resourceTimeGridDay',
        nowIndicator: true,
        selectable: true,
        slotMinTime: '10:00:00',
        slotMaxTime: '20:00:00',
        noEventsContent: 'There are no appointments booked!',
        eventResize: async function (info) {
          self.$q
            .dialog({
              title: 'Confirm',
              message: 'Are you sure you want to resize the appointment?',
              cancel: true,
              persistent: true,
              class: 'z-max'
            })
            .onOk(async () => {
              if (
                (await self.resizeEvent(
                  info.event.id,
                  info.endDelta.milliseconds
                )) === true
              ) {
                // self.$q.notify('Appointment Resized !')
                self.refetchEvents()
              } else {
                info.revert()
                self.refetchEvents()
              }
            })
            .onCancel(() => {
              info.revert()
            })
            .onDismiss(() => {
              info.revert()
            })
        },
        eventDrop: async function (info) {
          let staff = info.newResource && info.newResource.id
          if (!staff) {
            staff = ''
          }
          self.$q
            .dialog({
              title: 'Confirm',
              message:
                'Set new appointment date to ' +
                moment(info.event.start).format('LLLL'),
              cancel: true,
              persistent: true
            })
            .onOk(async () => {
              if (
                (await self.moveEvent(
                  info.event.id,
                  moment(info.event.start).format('lll'),
                  staff
                )) === true
              ) {
                self.refetchEvents()
                // self.$q.notify('Appointment Moved !')
              } else {
                // info.revert()
                self.refetchEvents()
              }
            })
            .onCancel(() => {
              info.revert()
            })
            .onDismiss(() => {
              info.revert()
            })
        },

        eventMouseEnter: function (event, jsEvent, view) {
          if (
            event.event.display === 'background' ||
            event.event.display === 'block' ||
            self.$q.platform.is.mobile ||
            self.viewFrequency === 'Month:Monthly' ||
            self.viewType === 'list:List'
          ) {
            return
          }
          $(event.el).addClass('fc-v-event fc-event-selected')
          // alert('Event: ' + event)
          if (self.persist) return
          self.appData = event.event.title
          self.currentApptID = event.event.id
          self.currentEvent = event.event
          self.$set(self.$data, 'currentEvent', event.event)
          self.modalShown = true
          self.$nextTick(function () {
            createPopper(event.el, self.$refs.apptCard.$el, {
              placement: 'auto'
            })
          })

          // console.log(event.event.title)
          // self.$modal.show('appt-window')
          // self.$nextTick(() => {
          //   self.popper = true
          //  })
        },
        eventMouseLeave: function (event, jsEvent, view) {
          if (
            event.event.display === 'background' ||
            event.event.display === 'block' ||
            self.$q.platform.is.mobile ||
            self.viewFrequency === 'Month:Monthly' ||
            self.viewType === 'list:List'
          ) {
            return
          }
          $(event.el).removeClass('fc-v-event fc-event-selected')
          // alert('Event: ' + event)
          if (self.persist) return
          self.modalShown = false
          // self.appData = ''
          // self.$modal.hide('appt-window')
          self.$nextTick(() => {
            self.popper = false
          })
        },
        customButtons: {
          gotoDate: {
            text: 'Date',
            click: function () {
              self.gotoDateDialog = true
            }
          },
          parked: {
            text: 'Park',
            click: function () {
              this.persist = false
              this.popper = false
              self.editAppointment(
                self.editID,
                moment(self.currentDateComp, 'dddd, MMMM Do').format(
                  'MM/DD/YYYY'
                )
              )
            }
          },
          today: {
            text: 'Today',
            click: function () {
              const calendarApi = self.$refs.fullCalendar.getApi()
              calendarApi.gotoDate(new Date(moment()))
            }
          },
          refresh: {
            text: 'Refresh',
            click: function () {
              self.refetchEvents()
              // self.$q.notify('refreshed!')
            }
          }
        },
        slotLabelContent: function (info) {
          return {
            html:
              '<span style="font-size:13px;">' +
              moment(info.date).format('hh:mm a') +
              '</span>'
          }
        },
        resourceLabelContent: function (info) {
          const title = info.resource.title
          return title
        },
        dayCellContent: function (info) {
          // const calendarApi =
          //  self.$refs.fullCalendar && self.$refs.fullCalendar.getApi()
          // const minSize = calendarApi.getOption('dayMinWidth')
          if (
            self.$q.platform.is.mobile ||
            info.view.type.indexOf('Month') > -1 ||
            info.view.type.indexOf('list') > -1
          ) {
            return
          }
          return {
            html: $('.fc-timegrid-axis-chunk')
              .clone()
              .show()
              .html() || ''
          }
        },
        dayCellDidMount: function () {},
        resourceLabelDidMount: function (info) {
          if (info.resource.id === '0') {
            info.el.innerHTML = 'No stylists booked'
            return
          }
          if (self.$q.screen.name === 'xs' && self.$q.platform.is.mobile) {
            info.el.innerHTML = info.resource.title
            return
          }
          if (info.view.type === 'timeGridDay' || info.view.type === 'timeGridWeek') {
            return
          }
          self.$nextTick(() => {
            const img =
              typeof info.resource.extendedProps.image === 'object'
                ? info.resource.extendedProps.image.join('')
                : false
            const title =
              '<div class="text-center"  >' +
              info.resource.title.split(' ')[0] +
              '</div>'
            if (!img) {
              info.el.innerHTML = `<div style="padding-top:5px;">
            <div style="margin:auto;padding-top:10px;background-color:${
              info.resource.extendedProps.staffColor
            };color:${info.resource.extendedProps.textColor};" class=" 
            text-center avatar text-h5 vertical-middle" style="padding:15px;">${
              typeof info.resource.title === 'string' &&
              info.resource.title.length > 0
                ? info.resource.title[0].toUpperCase()
                : ''
            }</div></div>${title}`
            } else {
              info.el.innerHTML = `<div style="padding-top:5px" class="text-center"><img src="${img}" class="avatar"></div>${title}`
            }
          })
        },
        eventClick: function (info) {
          if (info.event.display === 'background') {
            return
          }
          // alert('Event: ' + info.event.title)
          // alert('Coordinates: ' + info.jsEvent.pageX + ',' + info.jsEvent.pageY)
          // alert('View: ' + info.view.type)
          self.apptCardKey = uid()
          self.persist = true
          self.appData = info.event.title
          self.currentApptID = info.event.id
          self.$set(self.$data, 'currentEvent', info.event)
          // console.log(event.event.title)
          self.$nextTick(() => {
            self.popper = true
            // self.$modal.show('appt-window')
          })
          // change the border color just for fun
          // info.el.style.borderColor = 'red'
        },
        // filterResourcesWithEvents: true,
        // groupByDateAndResource: true,
        selectMirror: true,
        headerToolbar: false,
        allDaySlot: false,
        displayEventTime: true,
        slotEventOverlap: true,
        weekends: true,
        longPressDelay: 750,
        eventLongPressDelay: 750,
        selectLongPressDelay: 750,
        navLinks: true,
        datesAboveResources: true,
        datesSet: function (info) {
          self.headerText = info.view.title
          self.resizecal()
          // const date = moment(info.start).format('ddd MMM Do YYYY')
          // self.gotoDate = moment(info.start).format('MM-DD-YYYY')
          // self.headerText = date
          // self.$q.localStorage.set('CALENDAR:currentDate', info.start)
        },
        stickyHeaderDates: true,
        viewDidMount: function (info) {
          if (!self.$q.platform.is.mobile) {
            $('.fc-timegrid-axis-chunk').hide()
          }
          self.currentView = info.view.type
          self.headerText = info.view.title
          self.resizecal()
          // self.fcMargin = self.calendarTopPosition
          //  self.print = false
        },
        views: {
          resourceTimeGridWeek: {
            type: 'resourceTimeGrid',
            duration: { days: 7 },
            buttonText: ''
          },
          resourceTimeGridMonth: {
            type: 'dayGrid',
            duration: { months: 1 },
            buttonText: ''
          },
          timeGridMonth: {
            type: 'dayGrid',
            duration: { months: 1 }
          },
          timeGridDay: {
            type: 'timeGrid',
            duration: { days: 1 }
          },
          dayGridDay: {
            type: 'timeGrid',
            duration: { days: 1 }
          }
        },
        navLinkDayClick: function (date) {
          const calendarApi = self.$refs.fullCalendar.getApi()
          self.changeView('resourceTimeGridDay')
          self.viewFrequency = 'Day:Daily'
          self.viewType = 'resourceTimeGrid:Stylists'
          calendarApi.gotoDate(date)
        },
        navLinkWeekClick: function (date) {
          const calendarApi = self.$refs.fullCalendar.getApi()
          self.changeView('resourceTimeGridWeek')
          self.viewFrequency = 'Week:Weekly'
          self.viewType = 'resourceTimeGrid:Stylists'
          calendarApi.gotoDate(date)
        },
        editable: true,
        select: function (info) {
          if (
            info.view.type.indexOf('Month') > -1 ||
            info.view.type === 'dayGridDay' ||
            info.view.type.indexOf('list') > -1
          ) {
            return
          }
          self.selectButtonShown = true
          self.$nextTick(() => {
            self.selectEvent = info
            self.selectButtonPositionY = info.jsEvent.pageY - 100
            self.selectButtonPositionX = info.jsEvent.pageX
            self.$set(
              self.$data,
              'selectedStaffForWorkingHours',
              info.resource
            )

            self.$refs.selectButton.show()
          })

          /*
          self.$nextTick(() => {
            if (info.jsEvent.toElement.className.indexOf('fc-highlight') > -1) {
              info.jsEvent.toElement.innerHTML = '<div style="font-size:14px" class="text-bold ' + (self.$q.dark.isActive ? 'text-blue-1' : 'text-blue-10') + '">' +
          moment(info.start).format('hh:mm A')
            }
          })
          */
        },
        eventDidMount: function (info) {
          if (self.viewFrequency === 'Month:Monthly' || self.viewType === 'list:List') {
            return
          }
          CardMaker(info, self)
        },
        dayMinWidth: (!(self.$q.screen.name === 'xs' || self.$q.platform.is.mobile)) ? 600 : 167,
        windowResize: function (arg) {
          self.resizecal()
        }
      },
      blockFontColor: 'white',
      fcMargin: self.calendarTopPosition, // self.calendarTopPosition,
      currentView: typeof self.$q.localStorage.getItem('CALENDAR:initialView') ===
          'string'
        ? self.$q.localStorage.getItem('CALENDAR:initialView')
        : 'resourceTimeGridDay',
      headerText: '',
      selectedCell: '',
      modalShown: false,
      editID: '',
      gotoDate: new Date(),
      gotoDateDialog: false,
      stylistRequested: false,
      newApptDialog: false,
      bookingStaffList: [],
      viewStaff: self.$q.localStorage.getItem('CALENDAR:viewStaff') || [],
      bookingStaff: [],
      selectedClientId: '',
      selectedServiceDuration: '',
      bookingNewService: [],
      selectedDay: '',
      selectedTimeStart: '',
      selectedStaff: '',
      selectedTimeEnd: '',
      Cname: '',
      Cnumber: '',
      Cemail: '',
      Csource: '',
      appointmentNotes: '',
      Cnotes: '',
      selectedNewClient: '',
      apptCardKey: uid(),
      popper: false,
      persist: false,
      bookingNewSearchText: '',
      clientBookingDialog: false,
      bookingNewList: [],
      servicesList: [],
      bookingNewSearchTextVal: '',
      maximizedToggleNewBooking: false,
      appData: '',
      currentApptID: '',
      bookingSource: '',
      bookingServices: [],
      selectedClientName: '',
      currentDateComp: '',
      editSingle: false,
      currentEvent: {},
      ajaxResourcesLoading: false,
      ajaxEventsLoading: false,
      ajaxLoading: false,
      currentResourcesInView: [],
      selectButtonShown: false,
      selectButtonPositionX: '',
      selectButtonPositionY: '',
      selectEvent: '',
      selectedStaffForWorkingHours: '',
      blockColor: this.$q.dark.isActive ? '#747474' : '#747474',
      blockDescription: 'Blocked',
      print: false,
      dayMinWidth: 0,
      viewFrequency:
        typeof self.$q.localStorage.getItem('CALENDAR:viewFrequency') ===
        'string'
          ? self.$q.localStorage.getItem('CALENDAR:viewFrequency')
          : 'Day:Daily',
      viewType:
        typeof self.$q.localStorage.getItem('CALENDAR:viewType') === 'string'
          ? self.$q.localStorage.getItem('CALENDAR:viewType')
          : 'resourceTimeGrid:Stylists',
      staffSelectedForView: self.$q.localStorage.getItem('CALENDAR:staffSelectedForView') || 'working',
      ajaxStatus: false,
      fitStaffToScreen: false,
      newApptKey: uid()
    }
  },
  components: {
    FullCalendar,
    appointmentCard,
    FUZIcon,
    FUZListSearch,
    FUZDialog,
    ColorPicker: FUZColorPicker,
    NewApptModal
  },
  async mounted () {
    window.calendar = this.goNext.bind(this)
    if (!this.$q.platform.is.mobile) {
      $('.fc-timegrid-axis-chunk').hide()
    }
    if (this.$refs.fullCalendar) {
      const calendarApi = this.$refs.fullCalendar.getApi()
      if (this.$q.screen.name === 'xs' && this.$q.platform.is.mobile) {
        calendarApi.setOption(
          'height',
          (this.getHeight() -
            $('#appHeader').height() -
            $('#appToolbar .q-page-sticky').height() -
            0) + 'px'
        )
      } else {
        calendarApi.setOption(
          'height',
          (this.getHeight() -
            $('#appHeader').height() -
            $('#appToolbar .q-page-sticky').height() + 0) + 'px'
        )
      }

      /*
      this.$nextTick(() => {
        setTimeout(() => {
          calendarApi.render()
        }, 500)
      })
    */
      calendarApi.updateSize()
    }

    const afterPrint = async () => {
      this.print = false
      const calendarApi =
        this.$refs.fullCalendar && this.$refs.fullCalendar.getApi()
      calendarApi.setOption('dayMinWidth', this.dayMinWidth)
      if (!this.$q.platform.is.mobile && this.dayMinWidth > 0) {
        $('.fc-timegrid-axis-chunk').hide()
      }
      this.refetchEvents()
      this.$nextTick(() => {
        calendarApi.render()
      })
    }

    window.onafterprint = afterPrint

    /*
    $('body').on('mouseover', '.fc-timegrid-slot-lane:not(#fchightlight)', function (e) {
      $('#fchightlight').fadeOut('slow')
      $('#fchightlight').remove()
      const date = moment($(this).attr('data-time'), ['h:m a', 'H:m']).format('hh:mm a')
      $(this).append('<span id="fchightlight" class="bg-primary text-white appCard">&nbsp;&nbsp;' + date + '&nbsp;&nbsp;</span>')
      var x = Math.round(e.clientX) - $('.fc-timegrid-slot.fc-timegrid-slot-label.fc-scrollgrid-shrink').width()
      const maxX = $(this).width() - ($('#fchightlight').width())
      if (x > maxX) {
        x = x - ($('#fchightlight').width() * 1.5)
      }
      x = x + 'px'
      $('#fchightlight').css({
        left: x,
        position: 'absolute',
        display: 'none'
      })
      $('#fchightlight').fadeIn()
    })
    $('body').on('mouseout', '.fc-timegrid-slot-lane', function (e) {
      // $(this).removeClass('bg-primary text-white')
      $('#fchightlight').fadeOut()
      $('#fchightlight').remove()
    })
    */
  },
  async created () {
    await this.handleMounted()
    this.viewFrequency =
      this.$q.localStorage.getItem('CALENDAR:viewFrequency') || 'Day:Daily'
    this.viewType =
      this.$q.localStorage.getItem('CALENDAR:viewType') ||
      'resourceTimeGrid:Stylists'
      // staffSelectedForView: 'working'
      // viewStaff
    this.staffSelectedForView = this.$q.localStorage.getItem('CALENDAR:staffSelectedForView') ||
      'working'
    this.viewStaff = this.$q.localStorage.getItem('CALENDAR:viewStaff') ||
      []
  },
  watch: {
    currentView (v) {
      if (v === 'resourceTimeGridDay') {
        this.viewFrequency = 'Day:Daily'
        this.viewType = 'resourceTimeGrid:Stylists'
      } else if (v === 'resourceTimeGridWeek') {
        this.viewFrequency = 'Week:Weekly'
        this.viewType = 'resourceTimeGrid:Stylists'
      } else if (v === 'resourceTimeGridMonth') {
        this.viewFrequency = 'Month:Monthly'
        this.viewType = 'resourceTimeGrid:Stylists'
      } else if (v === 'dayGridDay') {
        this.viewFrequency = 'Day:Daily'
        this.viewType = 'dayGrid:Stylists Combined'
      } else if (v === 'dayGridWeek') {
        this.viewFrequency = 'Week:Weekly'
        this.viewType = 'dayGrid:Stylists Combined'
      } else if (v === 'dayGridMonth') {
        this.viewFrequency = 'Month:Monthly'
        this.viewType = 'dayGrid:Stylists Combined'
      } else if (v === 'listDay') {
        this.viewFrequency = 'Day:Daily'
        this.viewType = 'list:List'
      } else if (v === 'listWeek') {
        this.viewFrequency = 'Week:Weekly'
        this.viewType = 'list:List'
      } else if (v === 'listMonth') {
        this.viewFrequency = 'Month:Monthly'
        this.viewType = 'list:List'
      } else if (v === 'timeGridDay') {
        this.viewFrequency = 'Day:Daily'
        this.viewType = 'timeGrid:Stylists Combined'
      }
    },
    viewId (v) {
      this.$q.localStorage.set('CALENDAR:viewFrequency', this.viewFrequency)
      this.$q.localStorage.set('CALENDAR:viewType', this.viewType)
      this.$q.localStorage.set('CALENDAR:initialView', v)
      this.changeView(v)
      setTimeout(() => {
        this.refetchEvents()
      }, 500)
    },
    refreshEvents (v) {
      this.refetchEvents()
    }
  },
  computed: {
    viewId () {
      return this.viewType.split(':')[0] + this.viewFrequency.split(':')[0]
    },
    viewLabel () {
      return (
        this.viewFrequency.split(':')[1] + ' ' + this.viewType.split(':')[1]
      )
    },
    calendarTopPosition () {
      return 'margin:38px;'
      /*
      const view = this.currentView
      if (view === 'resourceTimeGridDay') {
        return 'margin-top:38px'
      } else if (view === 'timeGridWeek') {
        return 'margin-top:38px'
      } else if (view === 'dayGridMonth') {
        return 'margin-top:38px'
      } else if (view === 'dayGridDay') {
        return 'margin-top:38px'
      } else {
        return 'margin-top:38px'
      }
      */
    },
    refreshEvents () {
      return this.$store.state.app.refreshEvents
    },
    selectedServiceTimeEnd () {
      const formattedString = moment(this.selectedTimeStart, 'hh:mmA')
        .add(this.selectedServiceDuration, 'minute')
        .format('hh:mmA')
      return formattedString
    },
    currentDate () {
      const calendarApi =
        this.$refs.fullCalendar && this.$refs.fullCalendar.getApi()
      return calendarApi && calendarApi.getDate()
    }
  },
  methods: {
    bookNewAppt (event) {
      this.newEvent = event
      this.newApptKey = uid()
      this.$nextTick(() => {
        this.$refs.newApptModal.show()
      })
    },
    callOutsideVue () {
      alert('working!!!!:)))))))')
    },
    resizecal () {
      const self = this
      if (!(self.$q.screen.name === 'xs' || self.$q.platform.is.mobile)) {
        $('.fc-timegrid-axis-chunk').hide()
      }
      const calendarApi = self.$refs.fullCalendar.getApi()
      if (self.$q.screen.name === 'xs' || self.$q.platform.is.mobile) {
        calendarApi.setOption(
          'height',
          self.getHeight() -
                $('#appHeader').height() -
                $('#appToolbar .q-page-sticky').height() -
                0 +
                'px'
        )
      } else {
        calendarApi.setOption(
          'height',
          (self.getHeight() -
                $('#appHeader').height() -
                $('#appToolbar .q-page-sticky').height()) +
                'px'
        )
      }
      setTimeout(() => {
        calendarApi.updateSize()
      })
      setTimeout(() => {
        self.refetchEvents()
      }, 500)
      // window.resize = this.resizecal.bind(this)
    },
    rerenderCalendar () {
      this.$q.localStorage.set('CALENDAR:staffSelectedForView', this.staffSelectedForView)
      this.$q.localStorage.set('CALENDAR:viewStaff', this.viewStaff)
      const calendarApi =
        this.$refs.fullCalendar && this.$refs.fullCalendar.getApi()
      calendarApi.refetchResources()
      // this.refetchEvents()
      this.resizecal()
    },
    printCalendar () {
      this.print = true
      const calendarApi =
        this.$refs.fullCalendar && this.$refs.fullCalendar.getApi()
      this.dayMinWidth = calendarApi.getOption('dayMinWidth')
      calendarApi.setOption('dayMinWidth', 0)
      this.refetchEvents()
      calendarApi.updateSize()
      calendarApi.render()
      // this.resizecal()
      this.$nextTick(() => {
        window.print()
      })
    },
    fitStylists () {
      const calendarApi =
        this.$refs.fullCalendar && this.$refs.fullCalendar.getApi()
      calendarApi.setOption('dayMinWidth', 0)
      calendarApi.render()
    },
    expandStylists () {
      const calendarApi =
        this.$refs.fullCalendar && this.$refs.fullCalendar.getApi()
      calendarApi.setOption('dayMinWidth', 164)
      if (!this.$q.platform.is.mobile) {
        $('.fc-timegrid-axis-chunk').hide()
      }

      calendarApi.render()
    },
    async setStaffBlockHours () {
      if (this.blockDescription === '') {
        this.$q.dialog({
          component: FUZDialog,
          // persistent: true,
          ok: false,
          cancel: false,
          iconPath: 'Warning',
          iconWidth: 150,
          iconHeight: 150,
          message: 'Please add a block description',
          buttons: {
            ok: true
          }
        })
        return
      }
      if (
        !this.selectedStaffForWorkingHours ||
        this.selectedStaffForWorkingHours === '' ||
        (this.selectedStaffForWorkingHours &&
          this.selectedStaffForWorkingHours.id === '0')
      ) {
        this.$q
          .dialog({
            component: FUZDialog,
            // persistent: true,
            ok: false,
            cancel: false,
            iconPath: 'Warning',
            iconWidth: 150,
            iconHeight: 150,
            message:
              'Add block time for every working stylist on ' +
              moment(this.selectEvent.start).format('MM/DD/YYYY') +
              '? This will block the whole day for the selected time!',
            buttons: {
              ok: true
            }
          })
          .onDismiss(async () => {
            await this.saveBlockTime()
          })
        return
      }
      await this.saveBlockTime()
    },
    async saveBlockTime () {
      const e = this.selectEvent
      // selectEvent
      // selectedStaffForWorkingHours
      await this.$m('addBlockHours^STAFF', {
        start: moment(e.start).format('hh:mm a'),
        end: moment(e.end).format('hh:mm a'),
        day: moment(e.start).format('MM/DD/YYYY'),
        staff:
          this.selectedStaffForWorkingHours &&
          this.selectedStaffForWorkingHours.id
            ? this.selectedStaffForWorkingHours.id
            : 0,
        title: this.blockDescription,
        color: this.blockColor,
        fontColor: this.blockFontColor
      })
      // const calendarApi = this.$refs.fullCalendar.getApi()
      // calendarApi.refetchResources()
      this.refetchEvents()
      this.$refs.selectButton.hide()
      this.selectButtonShown = false
      this.$refs.selectStylistBlockDialog.hide()
    },

    async setStaffAndWorkingHours () {
      if (
        this.selectedStaffForWorkingHours === '' ||
        (this.selectedStaffForWorkingHours &&
          this.selectedStaffForWorkingHours.id === '0')
      ) {
        this.$q.dialog({
          component: FUZDialog,
          // persistent: true,
          ok: false,
          cancel: false,
          iconPath: 'Warning',
          iconWidth: 150,
          iconHeight: 150,
          message: 'Please select a stylist',
          buttons: {
            ok: true
          }
        })
        return
      }
      const e = this.selectEvent
      // selectEvent
      // selectedStaffForWorkingHours
      await this.$m('addWorkingHours^STAFF', {
        start: moment(e.start).format('hh:mm a'),
        end: moment(e.end).format('hh:mm a'),
        day: moment(e.start).format('MM/DD/YYYY'),
        staff: this.selectedStaffForWorkingHours.id
      })
      const calendarApi = this.$refs.fullCalendar.getApi()
      calendarApi.refetchResources()
      this.$refs.selectButton.hide()
      this.selectButtonShown = false
      this.$refs.selectStylistForWorkingHoursDialog.hide()
    },
    async addworkingHours (e) {
      if (
        (e.resource && e.resource.id === '0') ||
        !e.resource ||
        !e.resource.id
      ) {
        this.$refs.selectStylistForWorkingHoursDialog.show()
        return
      }
      await this.$m('addWorkingHours^STAFF', {
        start: moment(e.start).format('hh:mm a'),
        end: moment(e.end).format('hh:mm a'),
        day: moment(e.start).format('MM/DD/YYYY'),
        staff: e.resource.id
      })
      const calendarApi = this.$refs.fullCalendar.getApi()
      calendarApi.refetchResources()
      this.$refs.selectButton.hide()
      this.selectButtonShown = false
    },
    onSelectStylistForWorkingHoursDialogHide () {
      this.$emit('hide')
    },
    onSelectStylistBlockDialogHide () {
      this.$emit('hide')
    },
    moment (date) {
      return moment(date)
    },
    handleSwip (e) {
      if (e.duration > 20 && e.direction === 'right') {
        this.goPrev()
      } else if (e.duration > 20 && e.direction === 'left') {
        this.goNext()
      }
    },
    getHeight () {
      var div, h
      div = document.createElement('div')
      div.style.height = '100vh'
      div.style.maxHeight = 'none'
      div.style.boxSizing = 'content-box'
      document.body.appendChild(div)
      h = div.clientHeight
      document.body.removeChild(div)
      return h
    },
    changeView (view) {
      const calendarApi = this.$refs.fullCalendar.getApi()
      calendarApi.changeView(view)
      this.print = false
    },
    goToday () {
      const calendarApi = this.$refs.fullCalendar.getApi()
      calendarApi.today()
      this.print = false
    },

    goNext () {
      const calendarApi = this.$refs.fullCalendar.getApi()
      calendarApi.next()
      this.print = false
    },
    goPrev () {
      const calendarApi = this.$refs.fullCalendar.getApi()
      calendarApi.prev()
      this.print = false
    },
    scrolled (position) {
      // console.log(position)
    },
    editSingleService () {
      this.newApptDialog = false
      setTimeout(async () => {
        await this.editAppointment(this.editID)
      }, 500)
    },
    setCurrentDate () {
      this.currentDateComp = this.currentDate()
    },
    parkAppointment (id) {
      this.editID = id
      this.persist = false
      this.popper = false
      this.$q.notify('Appointment Parked!')
    },
    async editAppointment (id, parkedDate) {
      if (id === '') {
        this.$q.notify('Nothing Parked!')
        return
      }
      this.onResetClient()
      this.persist = false
      this.popper = false
      this.editID = id
      const data = await this.$M('editAppointment^SALON', {
        id,
        single: this.editSingle
      })
      this.bookingNewSearchText = ''
      this.Cname = ''
      this.Cnumber = ''
      this.Cemail = ''
      this.Csource = ''
      this.Cnotes = ''
      const {
        clientId,
        services,
        staff,
        notes,
        requested,
        date,
        time,
        name
      } = data.data
      this.selectedClientId = clientId
      this.bookingNewService = services
      this.bookingStaff = staff
      this.appointmentNotes = notes
      this.stylistRequested = requested
      this.newApptDialog = true
      this.selectedTimeStart = time
      this.selectedDay = date
      this.selectedClientName = name
      if (parkedDate) {
        this.selectedDay = parkedDate
      }
      this.getDuration(this.bookingNewService)
    },
    gotoDateCalendar () {
      const calendarApi = this.$refs.fullCalendar.getApi()
      calendarApi.gotoDate(new Date(this.gotoDate))
      this.print = false
    },
    async moveEvent (id, start, staff) {
      // console.log(id, start, staff)
      const data = await this.$M('moveEvent^BOOKING', {
        id,
        start,
        staff
      })
      return data && data.status === 'moved'
    },
    async resizeEvent (id, length) {
      const data = await this.$M('resizeEvent^BOOKING', {
        id,
        length
      })
      return data && data.data && data.data.status === 'resized'
    },
    getDuration (val) {
      let selectedServiceDuration = 0
      val.map(x => {
        selectedServiceDuration = selectedServiceDuration + x.length
      })
      this.selectedServiceDuration = selectedServiceDuration
      return selectedServiceDuration
    },
    restNewClientForm () {
      this.$q
        .dialog({
          title: 'Confirm',
          message: 'Are you sure you want to reset this form?',
          cancel: true,
          persistent: true
        })
        .onOk(() => {
          this.onResetClient()
        })
        .onOk(() => {
          // console.log('>>>> second OK catcher')
        })
        .onCancel(() => {
          // console.log('>>>> Cancel')
        })
        .onDismiss(() => {
          // console.log('I am triggered on both OK and Cancel')
        })
    },
    onResetClient () {
      this.bookingNewSearchText = ''
      this.selectedClientId = ''
      this.bookingNewService = []
      this.bookingStaff = ''
      this.Cname = ''
      this.Cnumber = ''
      this.Cemail = ''
      this.Csource = ''
      this.appointmentNotes = ''
      this.Cnotes = ''
      this.stylistRequested = false
      this.editID = ''
    },
    refetchEvents () {
      const calendarApi = this.$refs.fullCalendar.getApi()
      calendarApi.refetchResources()
      calendarApi.refetchEvents()
    }, // getDate
    async handleMounted () {
      // let data = await this.$M('getAppointments^AR')
      // this.events = data.data.events
      const data = await this.$m('GetList^FUZLIST', {
        type: 'CLIENTS',
        routine: 'List^CLIENTS',
        search: ''
      })
      if (data && data.list) {
        this.bookingNewList = data.list
      } else {
      }
      const data2 = await this.$m('GetList^FUZLIST', {
        type: 'SERVICES',
        routine: 'List^SERVICES',
        search: ''
      })
      if (data2 && data2.list) {
        this.bookingServices = data2.list
      } else {
      }
      const data3 = await this.$m('GetList^FUZLIST', {
        type: 'STAFF',
        routine: 'List^STAFF',
        search: ''
      })
      if (data3 && data3.list) {
        this.bookingStaffList = data3.list
      } else {
      }
    },
    handleDateClick (e) {
      // console.log(e)
    },
    async handleSelect (e) {
      this.newApptDialog = false
      this.onResetClient()
      this.editID = ''
      this.$nextTick(async () => {
        this.newApptDialog = true
        const data = await this.$M('getNewBooking^AR', {
          start: e.start,
          end: e.end,
          resource: {
            title: e.resource.title
          }
        })
        this.selectedCell =
          data.data.day + '   ' + data.data.start + '-' + data.data.end
        this.selectedStaff = e.resource.title
        this.bookingStaff = e.resource.title
        this.selectedDay = data.data.date
        this.selectedTimeStart = data.data.start
        this.selectedTimeEnd = data.data.end
        // this.$modal.show('new-appt-window')
      })
    },
    async handleMountedBookingNew (val, update, abort) {
      this.bookingNewSearchTextVal = val
      update(async () => {
        const data = await this.$M('getClients^AR', {
          searchText: val
        })
        if (data && data.data && data.data.list) {
          this.bookingNewList = data.data.list
        } else {
          abort()
        }
      })
    },
    async handleMountedBookingStaff (val, update, abort) {
      update(async () => {
        const data3 = await this.$M('getStaff^SALON', {
          searchText: val
        })
        if (data3 && data3.data && data3.data.list) {
          this.bookingStaffList = data3.data.list
        } else {
          abort()
        }
      })
    },
    async handleMountedBookingNewService (val, update, abort) {
      // this.bookingNewService = val
      update(async () => {
        const data = await this.$M('getServices^SALON', {
          searchText: val
        })
        if (data && data.data && data.data.list) {
          this.bookingServices = data.data.list
        } else {
          abort()
        }
      })
    }
  }
}
</script>
<style>
.tooltip{
  z-index:4 !important;
}
.q-dialog-plugin{
  z-index:99999999999!important;
}
.fc .fc-bg-event {
  opacity: 1;
}

.fc .fc-timegrid-slot-label-cushion {
  text-align: left !important;
  float: left !important;
}
.fullcal-full-height {
  height: calc(100vh - 46px) !important;
  padding-top:40px!important;

}

.fc-event-main:not(.FUZ-app-main) {
  display: none;
}

.fc-resource .fc-scrollgrid-sync-inner {
  display: none !important;
}
.avatar {
  vertical-align: middle;
  width: 50px;
  height: 50px;
  border-radius: 50%;
}

.fuz-modal {
  pointer-events: auto;
}
.v--modal-overlay[data-modal="appt-window"] {
  background: transparent;
  pointer-events: none;
}
.v--modal-overlay[data-modal="new-appt-window"] {
  background: transparent;
  pointer-events: none;
}
.v--modal-overlay {
  z-index: 1 !important;
}

.fc-list-table td,
.fc-daygrid-day {
  border-width: 1px 0 0;
  padding: 2px 4px !important;
}

.bg-ns {
  background-color: #8b0000 !important;
  border-color: #8b0000 !important;
  color: white !important;
}

#fullCalendarLight .fc-scrollgrid-section-sticky td {
  background-color: #eceff1 !important;
  border-color: #eceff1 !important;
}

#fullCalendarDark .fc-scrollgrid-section-sticky td{
  background-color: #141414 !important;
  border-color: #141414 !important;
}
#fullCalendarLight.fc-theme-standard td
 {
  border: 1px solid #c8c8c8 !important;
}

#fullCalendarLight.fc-theme-standard th{
  border:none !important;
}

#fullCalendarLight.fc-theme-standard,
#fullCalendarLight .fc-scrollgrid {
  border: 1px solid #ffffff !important;
}

#fullCalendarDark.fc-theme-standard th {
  border:none !important;
}

#fullCalendarDark.fc-theme-standard td{
  border: 1px solid rgb(88, 88, 88) !important;
}
#fullCalendarDark.fc-theme-standard,
#fullCalendarDark .fc-scrollgrid {
  border: 1px solid #141414 !important;
}
#fullCalendarDark.fc .fc-timegrid-col.fc-day-today {
  background-color: #353535 !important;
}

#fullCalendarDark.fc .fc-non-business {
  background-color: rgba(116, 116, 116, 0.767);
}

#fullCalendarLight.fc .fc-non-business {
  background-color: #7a7a7ac2;
}

#fullCalendarDark.fc a.fc-daygrid-day-number {
  color: var(--q-color-info) !important;
  text-decoration: none;
  background-color: transparent;
  border-color: #141414 !important;
}

#fullCalendarLight.fc a.fc-daygrid-day-number {
  color: var(--q-color-primary) !important;
  text-decoration: none;
  background-color: transparent;
  border: none !important;
}

#fullCalendarDark .fc-timegrid-slot-label-cushion,
#fullCalendarDark .fc-timegrid-slot-label-frame {
  color: rgb(168, 167, 167) !important;
  background-color: #141414 !important;
  border-color: #141414 !important;
}

#fullCalendarLight .fc-timegrid-slot-label-cushion,
#fullCalendarLight .fc-timegrid-slot-label-frame {
  color: #797979 !important;
  background-color: #eceff1 !important;
  border-color: #eceff1 !important;
}

#fullCalendarLight
  .fc-timegrid-slot.fc-timegrid-slot-label.fc-timegrid-slot-minor {
  background-color: #eceff1 !important;
  border-color: #eceff1 !important;
}

#fullCalendarDark
  .fc-timegrid-slot.fc-timegrid-slot-label.fc-timegrid-slot-minor {
  background-color: #141414 !important;
  border-color: #141414 !important;
}
#fullCalendarDark.fc-theme-standard .fc-list-day-cushion {
  background-color: #141414 !important;
}

#fullCalendarLight.fc-theme-standard .fc-list-day-cushion {
  background-color: #ffffff !important;
}

#fullCalendarLight .fc-event-title,
#fullCalendarLight .fc-list-event-title,
#fullCalendarLight .fc-event-time {
  color: #000000 !important;
}

#fullCalendarDark .fc-list-table tr td {
  background-color: #000000 !important;
  color: #ffffff !important;
}
#fullCalendarLight .fc-list-table tr td {
  background-color: #ffffff !important;
  color: #000000 !important;
}
#fullCalendarDark .fc-event-title,
#fullCalendarDark .fc-list-event-title,
#fullCalendarDark .fc-event-time {
  color: #ffffff !important;
}

#fullCalendarDark .fc-list-event-time {
  color: #ffffff !important;
}

#fullCalendarLight .fc-list-event-time {
  color: #000000 !important;
}

#fullCalendarDark .fc-timegrid-event .fc-event-mirror {
  -webkit-box-shadow: 5px 5px 5px 0px rgba(160, 160, 160, 0.507);
  -moz-box-shadow: 5px 5px 5px 0px rgba(160, 160, 160, 0.507);
  box-shadow: 5px 5px 5px 0px rgba(160, 160, 160, 0.507);
  border-radius: 10px 10px 10px 10px;
  -moz-border-radius: 10px 10px 10px 10px;
  -webkit-border-radius: 10px 10px 10px 10px;
  border: 0px solid rgba(160, 160, 160, 0.507);
}

#fullCalendarLight .fc-timegrid-event .fc-event-mirror {
  -webkit-box-shadow: 5px 5px 5px 0px #444;
  -moz-box-shadow: 5px 5px 5px 0px #444;
  box-shadow: 5px 5px 5px 0px #444;
  border-radius: 10px 10px 10px 10px;
  -moz-border-radius: 10px 10px 10px 10px;
  -webkit-border-radius: 10px 10px 10px 10px;
  border: 0px solid #444;
}
#fullCalendarLight .fc-timegrid-event-harness-inset .fc-timegrid-event,
#fullCalendarLight .appCard:not(.fc-list-event):not(.fc-daygrid-dot-event) {
  -webkit-box-shadow: 10px 10px 10px 0px #444;
  -moz-box-shadow: 10px 10px 10px 0px #444;
  box-shadow: 15px 15px 15px 0px #444;
  border-radius: 7px 7px 7px 7px;
  -moz-border-radius: 7px 7px 7px 7px;
  -webkit-border-radius: 7px 7px 7px 7px;
  border: 0px solid #000000;
}
#fullCalendarDark .fc-timegrid-event-harness-inset .fc-timegrid-event,
#fullCalendarDark .appCard:not(.fc-list-event):not(.fc-daygrid-dot-event) {
  -webkit-box-shadow: 10px 10px 10px 0px  rgb(56, 56, 56);
  -moz-box-shadow: 10px 10px 10px 0px rgb(56, 56, 56);
  box-shadow: 15px 15px 15px 0px  rgb(56, 56, 56);
  border-radius: 7px 7px 7px 7px;
  -moz-border-radius: 7px 7px 7px 7px;
  -webkit-border-radius: 7px 7px 7px 7px;
  border: 0px solid #FFFFFF;
}

#fullCalendarDark .appBlockCard{
  border-radius: 0 !important;
  box-shadow: none !important;
}
#fullCalendarLight .appBlockCard {
  border-radius: 0 !important;
  box-shadow: none !important;
}

.fc-event-resizer {
  width:10px !important;
 height:10px !important;;

}

</style>
