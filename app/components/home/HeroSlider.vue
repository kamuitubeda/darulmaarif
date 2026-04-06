<template>
  <div class="mb-6 group">
    <UCarousel
      ref="carouselRef"
      :items="activeSlides"
      :ui="{
        item: 'w-full snap-center',
        indicators: {
          wrapper: 'absolute bottom-3 mt-4 flex items-center justify-center gap-2',
          base: 'w-2 h-2 rounded-full transition-all duration-300',
          active: 'bg-green-500 w-4',
          inactive: 'bg-white/50 hover:bg-white/80'
        }
      }"
      indicators
      class="rounded-2xl overflow-hidden shadow-sm border border-gray-100"
    >
      <template #default="{ item }">
        <NuxtLink :to="item.link || '#'" class="relative w-full aspect-[16/9] sm:aspect-[2/1] bg-gray-200 block overflow-hidden tap-highlight-transparent cursor-pointer">
          <img :src="item.image" :alt="item.title" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105" />
          
          <!-- Gradient overlay -->
          <div class="absolute inset-0 bg-gradient-to-t from-gray-900/90 via-gray-900/40 to-transparent"></div>
          
          <!-- Content -->
          <div class="absolute bottom-0 left-0 right-0 p-4 sm:p-6 text-white transform transition-transform duration-300">
            <h3 class="font-extrabold text-base sm:text-xl leading-tight mb-1.5 drop-shadow-md">{{ item.title }}</h3>
            <p v-if="item.description" class="text-xs sm:text-sm text-gray-200 line-clamp-2 pr-4">{{ item.description }}</p>
          </div>
        </NuxtLink>
      </template>
    </UCarousel>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from 'vue'

const props = defineProps({
  slides: {
    type: Array,
    default: () => []
    // Expected CMS object structure:
    // { title, description, image, link, order, is_active }
  },
  autoplayDelay: {
    type: Number,
    default: 5000 // 5 seconds
  }
})

const carouselRef = ref(null)
let autoplayInterval = null

// Filter out inactive slides and sort by order field
const activeSlides = computed(() => {
  return [...props.slides]
    .filter(slide => slide.is_active !== false)
    .sort((a, b) => (a.order || 0) - (b.order || 0))
})

// Setup Autoplay mechanism
const startAutoplay = () => {
  if (activeSlides.value.length <= 1) return
  
  autoplayInterval = setInterval(() => {
    if (!carouselRef.value) return
    
    // Nuxt UI UCarousel exposes page and pages properties
    // Check if at the end, then loop back to the first page
    if (carouselRef.value.page === carouselRef.value.pages) {
      carouselRef.value.select(0)
    } else {
      carouselRef.value.next()
    }
  }, props.autoplayDelay)
}

const stopAutoplay = () => {
  if (autoplayInterval) {
    clearInterval(autoplayInterval)
  }
}

onMounted(() => {
  startAutoplay()
})

onBeforeUnmount(() => {
  stopAutoplay()
})
</script>

<style scoped>
.tap-highlight-transparent {
  -webkit-tap-highlight-color: transparent;
}
</style>
