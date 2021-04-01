//- (:style="{ fontSize:  '20px' }")
<template>
<div class="eg-theme-gourmet" id="EagleRecipes">
    <div class="eg-slideshow">
        <v-slide>
            <h1>Eagle Recipes</h1><img class="logo" src="./eagle-jam.png" />
            <p class="center">100% Pure Code, no Artificial Swag</p>
        </v-slide>
        <v-slide>
            <h3>Getting started</h3>
            <p>You should first learn about <a href='https://vuejs.org/' target='_blank'>Vue.js</a> and <a href='https://vuejs.org/' target='_blank'>Pug</a>, which we will use to make slideshows.
            </p>
            <p>Once you have installed Node/NPM, download the demo and start from there:</p>
            <eg-code-block lang="bash">git clone https://github.com/Zulko/eaglejs-demo.git cd eaglejs-demo npm install npm run dev
            </eg-code-block>
        </v-slide>
        <v-slide :steps="3">
            <h3>Writing a slideshow</h3>
            <p>A slideshow is contained in a Vue file.</p>
            <div class="subslide" v-if="step === 1">
                <p>The &lt;template&gt; tag provides the slideshow's structure:</p>
                <eg-code-block lang="html">&lt;template lang='pug'&gt; #MyFirstSlideshow .eg-slideshow slide h1 Hi there ! p I am the first slide ! slide h1 Hi there ! p I am the second slide ! &lt;/template&gt;
                </eg-code-block>
            </div>
            <div class="subslide" v-if="step === 2">
                <p>The &lt;script&gt; tag loads Eagle and specifies options:</p>
                <eg-code-block lang="html">&lt;script&gt; import eagle from 'eagle.js' export default { mixins: [ eagle.slideshow ], infos: { title: 'Your First Slideshow', description: 'A boilerplate to get you started', path: 'your-first-slideshow' } } &lt;/script&gt;
                </eg-code-block>
            </div>
            <div class="subslide" v-if="step === 3">
                <p>The &lt;style&gt; tag specifies custom styles for your components (more on themes later)</p>
                <eg-code-block lang="scss">&lt;style lang='scss'&gt; @import url(https://fonts.googleapis.com/css?family=Raleway); #MyFirstSlideshow{ .eg-slideshow{ font-family: 'Raleway'; background-color: #eef; ... } &lt;/style&gt;
                </eg-code-block>
            </div>
        </v-slide>
        <v-slide :steps="3">
            <h3>Minimal slideshow</h3>
            <eg-code-block lang="html">.eg-slideshow slide h1 Hi there ! p I am slide 1 slide h1 Hello p I am slide 2 slide h1 Hello p I am slide 3
            </eg-code-block>
            <div class="demo-slideshow">
                <p>Result:</p>
                <demo-slideshow :embedded="true" :firstSlide="1" :lastSlide="3"></demo-slideshow>
            </div>
        </v-slide>
        <v-slide :steps="2">
            <h3>Slides with transitions</h3>
            <eg-code-block lang="html">slide(enter='fadeIn' leave='fadeOut') h3 I am a fading slide ! p I fade in and fade away slide(enter='bounceInRight' leave='bounceOutLeft') h3 I'm a bouncing slide p I bounce in and out</eg-code-block>
            <div class="demo-slideshow">
                <p>Result:</p>
                <demo-slideshow :embedded="true" :firstSlide="4" :lastSlide="5"></demo-slideshow>
            </div>
        </v-slide>
        <v-slide :steps="4">
            <h3>Bullet points</h3>
            <eg-code-block lang="html">slide(:steps=4) h3 How to impress people p(v-if='step >= 2') Wear bright colors p(v-if='step >= 3') Learn to juggle p(v-if='step >= 4') Use Eagle.JS</eg-code-block>
            <div class="demo-slideshow">
                <p>Result:</p>
                <demo-slideshow :embedded="true" :firstSlide="6" :lastSlide="6"></demo-slideshow>
            </div>
        </v-slide>
        <v-slide :steps="4">
            <h3>Animations</h3>
            <p>Eagle supports
                <a href='https://daneden.github.io/animate.css/' target='_blank'>Animate.CSS</a> animations, and more</p>
            <eg-code-block lang="html">slide(:steps=4) h3 How to impress people eg-transition(enter='fadeInRight') p(v-if='step >= 2') Wear bright colors eg-transition(enter='fadeInLeft') p(v-if='step >= 3') Learn to juggle eg-transition(enter='fadeInDown') p(v-if='step >= 4')
                Use Eagle.JS</eg-code-block>
            <div class="demo-slideshow">
                <p>Result:</p>
                <demo-slideshow :embedded="true" :firstSlide="7" :lastSlide="7"></demo-slideshow>
            </div>
        </v-slide>
        <v-slide :steps="4">
            <h3>Dynamic components</h3>
            <p>There are many other ways to animate your slides with Vue.js. Here is just another example:</p>
            <eg-code-block lang="html">slide(:steps=4) h2 Eagle.JS is h3(v-if='step === 2') Simple h3(v-if='step === 3') Powerful h3(v-if='step === 4') Hackable
            </eg-code-block>
            <div class="demo-slideshow">
                <p>Result:</p>
                <demo-slideshow :embedded="true" :firstSlide="8" :lastSlide="8"></demo-slideshow>
            </div>
        </v-slide>
        <v-slide :steps="4">
            <h3>Animated SVGs</h3>
            <div class="subslide" v-if="step === 1">
                <p>You can use <b>v-if</b> and animation classes inside a SVG:</p>
                <eg-code-block lang="html">&lt;svg height="34mm" width="77mm" viewBox="0 0 272 119"&gt; &lt;circle v-if='step >= 1' cx="60" cy="65" r="50"/> &lt;circle v-if='step >= 2' class='animated bounce' cx="137" cy="65" r="50"/> &lt;circle v-if='step >= 3' cx="214" cy="65"
                    r="50"/> &lt;/svg>
                </eg-code-block>
            </div>
            <div class="subslide" v-if="step &gt;= 2">
                <p>Then include the SVG in your slide</p>
                <eg-code-block lang="html">slide(:steps=4) h2 Animated SVG include assets/animated.svg
                </eg-code-block>
                <div class="demo-slideshow">
                    <p>Result:</p>
                    <demo-slideshow :embedded="true" :firstSlide="9" :lastSlide="9"></demo-slideshow>
                </div>
            </div>
        </v-slide>
        <v-slide :steps="3">
            <h3>Subslides</h3>
            <eg-code-block lang="html">slide(:steps=3) h2 Some verses eg-transition(enter='fadeInRight' leave='fadeOutLeft') .subslide(v-if='step === 1') p Once it smiled a silent dell p Where the people did not dwell; eg-transition(enter='fadeInRight' leave='fadeOutLeft') .subslide(v-if='step
                === 2') p They had gone unto the wars, p Trusting to the mild-eyed stars, etc.
            </eg-code-block>
            <div class="demo-slideshow">
                <p>Result:</p>
                <demo-slideshow :embedded="true" :firstSlide="10" :lastSlide="10"></demo-slideshow>
            </div>
        </v-slide>
        <v-slide>
            <p>Hmmm... Looks like this slideshow is under construction. That would explain the general ugliness... Come back later for more !</p>
        </v-slide>
    </div>
</div>
</template>

<script>
import eagle from 'eagle.js'
import DemoSlideshow from './DemoSlideshow'

var TransitionedSlide = {
  mixins: [eagle.slide],
  props: {
    enter: { default: 'slideInRight' },
    leave: { default: 'slideOutLeft' }
  }
}

export default {
  mixins: [eagle.slideshow],
  name: 'EagleRecipes',
  data: function () {
    return {
      fullPageWidth: null,
      fullPageHeight: null,
      parentHeight: null,
      parentWidth: null
    }
  },
  infos: {
    title: 'Eagle recipes',
    description: 'For yummy presentations',
    path: 'eagle-recipes'
  },
  components: {
    'demo-slideshow': DemoSlideshow,
    'v-slide': TransitionedSlide
  }
}
</script>

<style lang='scss'>
@import 'node_modules/eagle.js/src/themes/gourmet/gourmet';
#EagleRecipes {
  a {
    font-weight: bold;
    cursor: pointer;
    color: black;
    text-decoration: none
  }
  h1 {
    margin-top: 0em;
  }
  .logo {
    display: block;
    margin: 0 auto;
    max-height: 8em;
  }
  .eg-slideshow {
    .eg-slide {
      .eg-slide-content {
        .demo-slideshow {
          position: relative;
          width: 12em;
          height: 8em;
          margin: 0 auto;
        }
      }
    }
  }
  .eg-slideshow.embedded-slideshow-theme {
    background-image: none;
    background-color: white;
  }
}
</style>
