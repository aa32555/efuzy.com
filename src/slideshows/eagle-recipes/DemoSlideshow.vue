<template>
<div id="DemoSlideshow">
  <div class="eg-slideshow">
    <slide>
      <h2>Hi there !</h2>
      <p>I am slide 1</p>
    </slide>
    <slide>
      <h2>Hi again !</h2>
      <p>I am slide 2</p>
    </slide>
    <slide>
      <h2>Hi third !</h2>
      <p>I am slide 3</p>
    </slide>
    <slide enter="fadeIn" leave="fadeOut">
      <h2>I'm a fading slide!</h2>
      <p>I fade in and fade away</p>
    </slide>
    <slide enter="bounceInRight" leave="bounceOutLeft">
      <h2>I'm a bouncing slide</h2>
      <p>I bounce in and out</p>
    </slide>
    <slide :steps="4">
      <h3>How to impress people</h3>
      <p v-if="step   >= 2">Wear bright colors</p>
      <p v-if="step   >= 3">Learn to juggle</p>
      <p v-if="step   >= 4">Use Eagle.JS</p>
    </slide>
    <slide :steps="4">
      <h3>How to impress people</h3>
      <eg-transition enter="fadeInRight">
        <p v-if="step   >= 2">Wear bright colors</p>
      </eg-transition>
      <eg-transition enter="fadeInLeft">
        <p v-if="step   >= 3">Learn to juggle</p>
      </eg-transition>
      <eg-transition enter="fadeInDown">
        <p v-if="step   >= 4">Use Eagle.JS</p>
      </eg-transition>
    </slide>
    <slide :steps="4">
      <h2>Eagle.JS is</h2>
      <h3 v-if="step === 2">Simple</h3>
      <h3 v-if="step === 3">Powerful</h3>
      <h3 v-if="step === 4">Hackable</h3>
    </slide>
    <slide :steps="3">
      <h2>Animated SVG</h2><svg height="33.7mm" width="76.9mm" version="1.1" viewBox="0 0 272 119">
  <circle v-if='step >= 1' cx="60" cy="65" r="30"/>
  <circle v-if='step >= 2' class='animated bounce' cx="137" cy="65" r="30"/>
  <circle v-if='step >= 3' cx="214" cy="65" r="30"/>
</svg>

    </slide>
    <slide :steps="3">
      <h2>Some verses</h2>
      <eg-transition enter="fadeInRight" leave="fadeOutLeft">
        <div class="subslide" v-if="step === 1">
          <p>Once it smiled a silent dell</p>
          <p>Where the people did not dwell;</p>
        </div>
      </eg-transition>
      <eg-transition enter="fadeInRight" leave="fadeOutLeft">
        <div class="subslide" v-if="step === 2">
          <p>They had gone unto the wars,</p>
          <p>Trusting to the mild-eyed stars,</p>
        </div>
      </eg-transition>
      <eg-transition enter="fadeInRight" leave="fadeOutLeft">
        <div class="subslide" v-if="step === 3">
          <p>Nightly, from their azure towers,</p>
          <p>To keep watch above the flowers,</p>
        </div>
      </eg-transition>
    </slide>
    <slide :steps="2">
      <h2>I am a slide</h2>
      <p>And a modal will appear</p>
      <eg-modal v-if="step === 2">
        <h3>I am a modal</h3>
      </eg-modal>
    </slide>
  </div>
</div>
</template>

<script>
import eagle from 'eagle.js'

export default {
  mixins: [eagle.slideshow],
  name: 'demoslide',
  infos: {
    title: 'Demo recipes',
    description: 'Demos for Eagle recipes',
    path: 'demo-recipes'
  }
}
</script>

<style lang='scss'>
@import url(https://fonts.googleapis.com/css?family=Raleway);
#DemoSlideshow {
  .eg-slideshow {
    background-color: white;
    background-image: none;
    p {
      font-size: 1.2em;
    }
    .eg-slide {
      h1, h2, h3, h4, h5, p, li, {
        font-family: 'Raleway'
      }
    }
    .eg-modal {
      background-color: rgba(0,0,0,0.8);
      color: white;
      h1, h2, h3, h4 {
        font-weight: bold;
      }
    }
  }
}
</style>
