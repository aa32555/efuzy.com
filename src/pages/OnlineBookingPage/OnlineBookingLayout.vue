<template>
<q-layout>
     <v-stepper v-if="showStepper" :steps="steps" v-model="step" :style="('width:100%;background-color:'+stepBackgroundColor)+';'" >
   </v-stepper>
 <q-page-container class="flex flex-center" :style="'height:100%;min-height:100vh;' +(bgType==='gradient'?'background-image:linear-gradient('+bgColor1+','+bgColor2+')':('background-image:'+bgImage))">
  <FUZPage style="height:100%;width:100%" class="flex flex-center">
<FUZDiv v-if="showAvatar" :colLG="5" style="background-color:inherit">
         <transition
          appear
          enter-active-class="animated slideInLeft"
          leave-active-class="animated slideInRight">
        <blockquote class="speech-bubble"><vue-typed-js :strings="[prompt]" >
                      <h4 class="typing"></h4>
                  </vue-typed-js>
           <cite></cite>
        </blockquote>
         </transition>
          <avataaars :style="$q.screen.gt.sm?'width:300px;height:300px':'width:150px;height:150px'" v-bind="avatarProps"/>
    </FUZDiv>
      <transition
        appear
       enter-active-class="animated slideInUp"
       leave-active-class="animated slideInDown">
    <FUZDiv :colLG="2" style="background-color:inherit;padding-top:25px" v-if="actionButtons&&showactionButtons" >
   <div v-for="(button,index) in actionButtons" :key="'actionButtoon-'+index">
     <span class="text-center flex flex-center"><cv-button
  style="font-size:1.5rem;height:100px;"
  :kind="button.type"
  @click="dispatchAction(button.onClick)"
>
       <q-icon :name="button.iconName" :class="button.iconClass" style="font-size: 4rem;" v-if="button.align==='left'" /> {{button.text}}
        <q-icon :name="button.iconName" :class="button.iconClass" style="font-size: 4rem;" v-if="button.align==='right'" />
</cv-button></span>
  <br>
   </div>
     </FUZDiv>
     </transition>
          <transition
            appear
            enter-active-class="animated slideInRight"
            leave-active-class="animated slideInLeft">
    <FUZDiv :colLG="5" style="background-color:inherit;" v-if="showAnimationC && showAnimation">
       <FUZDiv :colLG="12" style="background-color:inherit;margin:0 auto">
         <FUZLottie v-if="showAnimation"
            :animationData="animationPath"
            :loop="animationLoop"
            style="width:100%;height:100%;"/>
       </FUZDiv>
       </FUZDiv>
        </transition>
      <transition
        appear
       enter-active-class="animated slideInRight"
       leave-active-class="animated slideInLeft">
<FUZDiv :colLG="5" style="background-color:inherit" v-if="sideComponent && showsideComponent" >
    <component :is="sideComponent" v-bind="sideComponentProps" />
    </FUZDiv>
</transition>
  </FUZPage>
  <cv-modal
  style="z-index:3"
  ref="phoneNumberInput"
  :close-aria-label="'Close phone input'"
  :size="'small'"
    @primary-click="submitPhoneNumber"
    @secondary-click="$refs.phoneNumberInput.hide()"
  :auto-hide-off="false">
  <template  slot="label">Client verification</template>
  <template slot="title">Please enter your phone number</template>
  <template  slot="content">
    <q-input
    autofocus
    ref="phontInput"
    style="width:350px;margin:0 auto"
    hint="(123) 456-7890"
    type="tel"
    mask="(###) ###-####"
    rounded
    outlined
    label="Phone number"
    lazy-rules
    v-model="phoneNumber"
    />
    </template>
  <template slot="secondary-button">Cancel</template>
  <template slot="primary-button">Submit</template>
</cv-modal>
  <cv-modal
  style="z-index:3"
  ref="phoneVerfificationInput"
  :close-aria-label="'Close phone input'"
  :size="'small'"
    @primary-click="submitPhoneVerifyNumber"
    @secondary-click="$refs.phoneVerfificationInput.hide()"
  :auto-hide-off="false">
  <template  slot="label">Verification Code</template>
  <template slot="title">Please enter your verification code</template>
  <template  slot="content">
    <q-input
    autofocus
    ref="phoneVerifyInput"
    style="width:350px;margin:0 auto"
    type="tel"
    mask="####"
    rounded
    outlined
    label="Verification code"
    lazy-rules
    v-model="verifyCode"
    />
    </template>
  <template slot="secondary-button">Cancel</template>
  <template slot="primary-button">Submit</template>
</cv-modal>
    </q-page-container>
</q-layout>
</template>
<script>
import FUZDiv from '../../FUZ/FUZDiv'
import FUZPage from '../../FUZ/FUZPage'
import FUZDialog from '../../components/FUZDialog'
import Avataaars from 'vuejs-avataaars'
import FUZLottie from '../../FUZ/FUZLottie'
import { VStepper } from 'vue-stepper-component'
import { Dialog } from 'quasar'

export default {
  name: 'OnlineBookingLayout',
  props: ['bgColor1',
    'bgColor2',
    'bgImage',
    'prompt',
    'bgType',
    'step',
    'steps',
    'stepBackgroundColor',
    'avatarProps',
    'actionButtons',
    'animationPath',
    'animationLoop',
    'showAnimation',
    'sideComponent',
    'sideComponentProps'],
  components: {
    FUZDiv,
    FUZPage,
    Avataaars,
    FUZLottie,
    VStepper
  },
  data () {
    return {
      showStepper: false,
      showAvatar: false,
      showsideComponent: false,
      showactionButtons: false,
      showAnimationC: false,
      phoneNumber: '',
      verifyCode: ''
    }
  },
  mounted () {
    setTimeout(() => {
      this.showStepper = false
      this.showAvatar = true
      this.showsideComponent = true
      this.showactionButtons = true
      this.showAnimationC = true
    })
  },
  methods: {
    async dispatchAction (action) {
      await this[action]()
    },
    showPhoneVerfificationInput () {
      this.$refs.phoneVerfificationInput.show()
      setTimeout(() => {
        this.$refs.phoneVerifyInput.focus()
      }, 500)
    },
    showPhoneNumberInput () {
      this.$refs.phoneNumberInput.show()
      setTimeout(() => {
        this.$refs.phontInput.focus()
      }, 500)
    },
    submitPhoneVerifyNumber () {
      if (this.verifyCode.length !== 4) { this.error('A valid verification code is required! ') } else {
        this.$emit('nextStep', {
          step: 3,
          data: { code: this.verifyCode }
        })
        this.$refs.phoneVerfificationInput.hide()
      }
    },
    submitPhoneNumber () {
      if (this.phoneNumber.length !== 14) { this.error('A valid 10 digit phone number is required! ') } else {
        this.$emit('nextStep', {
          step: 2,
          data: { phone: this.phoneNumber }
        })
        this.$refs.phoneNumberInput.hide()
      }
    },
    error (message) {
      Dialog.create({
        component: FUZDialog,
        ok: false,
        cancel: false,
        iconPath: 'Warning',
        iconWidth: 150,
        iconHeight: 150,
        message,
        buttons: {
          ok: true
        }
      }).onOk(() => {
      }).onCancel(() => {
      }).onDismiss(() => {
      })
    }
  }
}
</script>
<style lang="scss">
// This solution uses transforms and a caret mixin.
// What will yours be? Fork this pen and share
// your solution in this comments.

// This pen's solution is on line 91.

/// DEMO
/// ==========================================================
$bg:darken(#2d6ddb, 10%);

/// REQUIRED
/// ==========================================================

$gutter: 20px;
$caret-unit: 25px;
$bubble-bg: #2d6ddb;
$bubble-color: white;
$cite-color: $bubble-color;

/// Opposite Direction
/// ==========================================================
/// Returns the opposite direction of each direction in a list
/// @author Hugo Giraudel
/// @param {List} $directions - List of initial directions
/// @return {List} - List of opposite directions

@function opposite-direction($directions) {
  $opposite-directions: ();
  $direction-map: (
    'top': 'bottom',
    'right': 'left',
    'bottom': 'top',
    'left': 'right',
    'center': 'center',
    'ltr': 'rtl',
    'rtl': 'ltr'
  );

  @each $direction in $directions {
    $direction: to-lower-case($direction);

    @if map-has-key($direction-map, $direction) {
      $opposite-directions: append($opposite-directions, unquote(map-get($direction-map, $direction)));
    } @else {
      @warn "No opposite direction can be found for `#{$direction}`. Direction omitted.";
    }
  }

  @return $opposite-directions;
}

/// Unit Removal
@function strip-unit($num) {
    @return $num / ($num * 0 + 1);
}

/// Triangle Mixin
/// ==========================================================

@mixin caret($point, $border-width, $color) {
  $opposite: opposite-direction($point);
  border: $border-width solid transparent;
  border-#{$opposite}: $border-width solid $color;
  border-#{$point}: 0;
  height: 0;
  width: 0;
}

/// Component
/// ==========================================================

.speech-bubble {
  filter: drop-shadow(-1px -1px 2px rgba(black, .10)) drop-shadow(1px 2px 2px rgba(black, .15));
  margin: 1rem;
  margin-bottom: ($gutter * 2);
  padding: 1.5rem 2rem;
  position: relative;
  font-family: 'Source Sans Pro', sans-serif;
  font-size: 1.2rem;
  font-weight: 400;
  background: $bubble-bg;
  color: $bubble-color;

  &::before {
    @include caret(bottom, ($caret-unit / 2), $bubble-bg);
    border-top-width: $caret-unit;
    content: '';
    display: block;
    position: absolute;
    left: 3rem;
    bottom: -$caret-unit;
    transform-origin: center;
    transform: rotate(90deg) skew(-(strip-unit($caret-unit))+deg) translateY($caret-unit / 1.5);
  }
}

.speech-bubble cite {
  position: absolute;
  bottom: -2rem;
  left: 4.5rem;
  font-size: 1rem;
  font-style: normal;
  font-weight: 300;
  letter-spacing: 0.5px;
  color: $cite-color;
}

.bx--modal-content {
    padding:5px !important;
    margin:0px !important;
}

</style>
