<template>
  <div class="eg-slideshow">
    <ImageSlide v-for="(image,i) in preloadedImages" :key="i"  :enter="(i===0) ? null : 'slideInRight'" leave="slideOutLeft" :url="image" />
  </div>
</template>
<script>
import { Slideshow, ImageSlide } from 'eagle.js'

export default {
  name: 'slide1',
  mixins: [Slideshow],
  components: {
    ImageSlide
  },
  data: function () {
    var images = {
      'baby bunnies': [
        'https://i.imgur.com/1PL2k1H.jpg',
        'https://i.imgur.com/GfFUcPQ.jpg',
        'https://i.imgur.com/et8w8Rn.gif'
      ],
      'funny kitties': [
        'https://i.imgur.com/P7iyH.png',
        'https://i.imgur.com/sHOqlJc.jpg',
        'https://i.imgur.com/wiAwNQZ.gif'
      ],
      'fluffy puppies': [
        'https://i.imgur.com/Scj7lzM.jpg',
        'https://i.imgur.com/FyFhTEE.jpg',
        'https://i.imgur.com/G62BWuI.gif'
      ]
    }
    return {
      images: images,
      preloadedImages: images['funny kitties']
    }
  }
}
</script>
