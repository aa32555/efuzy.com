import $ from 'jquery'

export default (info, self) => {
  const print = info.event.extendedProps.print
  const time = info.timeText
  const service = info.event.extendedProps.service || ''
  const name = info.event.extendedProps.name || ''
  const display = info.event.display
  const borderColor = info.event.extendedProps.statusColor1 || ''
  const statusColor1 = info.event.extendedProps.statusColor1 || ''
  const statusColor2 = info.event.extendedProps.statusColor2 || ''
  const staffColor1 = info.event.extendedProps.staffColor1 || ''
  const staffColor2 = info.event.extendedProps.staffColor2 || ''
  const gradientColor = ['to right', staffColor1, staffColor2]

  // const viewType = info.view.type
  const textColor = info.event.extendedProps.textColor
  // const statusColor = info.event.extendedProps.statusColor || 'red'
  const element = info.el
  let html
  if (print) {
    html = `${time} - ${name} - ${service}`
    $(element).html(html)
    return
  }

  if (display === 'background') {
    const margin = $('.fc-timegrid-axis-chunk').width() > 0 ? 0 : 63
    const width = $(element).width()
    const height = $(element).height() - 6
    html = `
    <div class="flex" style="border: 5px solid ${self.$q.dark.isActive ? 'white' : 'black'}">
        <div style="background-color:${statusColor1};height:${height}px;overflow:hidden;width:15px;">
        </div>
        <div class="col">
            <div class="column wrap justify-start" style="color:${textColor};font-size:14px;padding-left:5px;height:${height}px;overflow:hidden;">
                <div class="text-bold">${time}</div>
                <div class=" text-bold" style="font-size:14px">${name}</div>
                <div class="ellipsis">${service}</div>
            </div>
        </div> 
    </div>
    `
    $(element)
      .find('.fc-event-title')
      .hide()
    $(element)
      .parent()
      .width(width - margin)
      .css('position', 'absolute')
      .css('left', margin)
      .css('opacity', 0.5)
      .css('z-index', 2)
    $(element)
      .append(html)
  } else if (display === 'auto' && name && name.length) {
    const margin = $('.fc-timegrid-axis-chunk').width() > 0 ? 0 : 63
    const width = $(element).outerWidth()
    const height = $(element).outerHeight()
    const borderWidth = 0
    const statusWidth = 10

    // const resizer = $(element).closest('.fc-resizer').html()
    html = `
    <div class="flex FUZ-app-main appCard">
        <div style="background-color:${statusColor1};
            background-image: linear-gradient(${statusColor1},${statusColor2});
            border-top: ${borderWidth}px ridge ${borderColor};
            border-bottom: ${borderWidth}px ridge ${borderColor};
            border-left: ${borderWidth}px ridge ${borderColor};
            border-right: ${borderWidth}px ridge ${borderColor};
            height:${height}px;width:${statusWidth}px;">
        </div>
        <div class="col" style="
        background-image: linear-gradient(${gradientColor.join(', ')});
        background-size: cover;
        border-top: ${borderWidth}px ridge ${borderColor};
        border-bottom: ${borderWidth}px ridge ${borderColor};
        border-right: ${borderWidth}px ridge ${borderColor};
        height:${height}px;overflow:hidden;"
        >
            <div class="column wrap justify-start" style="color:${textColor};
            font-size:14px;padding-left:5px;overflow:hidden;height:${height - (borderWidth * 2)}px;
            ">
                <div class=" text-bold" style="font-size:18px;text-shadow: 17px 0px 20px ${textColor};" >${name}</div>
                <div class="text-bold">${time}</div>
                <div class="ellipsis">${service}</div>
            </div>
        </div> 
    </div>
    `
    $(element)
      .find('.fc-event-title fc-sticky')
      .remove()
      .css('background-color', borderColor)
    if (!$(element).closest('.fc-timegrid-event-harness-inset')[0]) {
      $(element)
        .parent()
        .width(width - margin - (borderWidth * 2))
        .css('position', 'absolute')
        .css('left', margin)
        .css('background-color', borderColor)
        //   fc-v-event fc-event fc-event-draggable fc-event-resizable fc-event-selected
        //   $(element)
        //   .parent()
        //   .addClass('fc-v-event fc-event fc-event-draggable fc-event-resizable')
    }
    $(element).html(html)
  } else if (display === 'auto' && name === '' && service === '') {
    console.log(info)
    html = `<span class="text-warning text-h1 text-bold flex flex-center absolute-bottom">${time}</span>`
    $(element).html(html)
  }
}
