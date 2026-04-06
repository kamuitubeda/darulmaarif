<template>
  <div class="grid grid-cols-4 sm:grid-cols-4 gap-y-6 gap-x-2 bg-white p-5 rounded-2xl shadow-sm border border-gray-100">
    <NuxtLink
      v-for="(item, index) in items"
      :key="index"
      :to="item.path"
      class="flex flex-col items-center gap-2 cursor-pointer group active:scale-95 transition-transform duration-200 tap-highlight-transparent"
    >
      <div 
        class="w-[52px] h-[52px] rounded-[18px] shadow-sm flex items-center justify-center text-white bg-gradient-to-br transition-all duration-300"
        :class="[item.color, item.gradient]"
      >
        <UIcon :name="item.icon" class="w-7 h-7 group-hover:scale-110 transition-transform duration-300" />
      </div>
      <span class="text-[10px] sm:text-xs text-center font-semibold text-gray-700 leading-tight">{{ item.label }}</span>
    </NuxtLink>
  </div>
</template>

<script setup>
defineProps({
  items: {
    type: Array,
    required: true,
    // Expects array of objects: { label, path, icon, color, gradient }
  }
})
</script>

<style scoped>
/* Ensures tapping on mobile doesn't show default semi-transparent block */
.tap-highlight-transparent {
  -webkit-tap-highlight-color: transparent;
}
</style>
