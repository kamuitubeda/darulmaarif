<template>
  <div class="flex items-center gap-2.5 mb-3 px-1">
    <div class="w-1 h-5 bg-green-500 rounded-full shrink-0"></div>
    <UIcon :name="icon" class="w-4 h-4 text-green-600 shrink-0" />
    <h2 class="font-extrabold text-gray-800 text-sm tracking-tight">{{ label }}</h2>
  </div>
</template>

<script setup>
defineProps({
  icon: { type: String, default: 'i-heroicons-bars-3' },
  label: { type: String, required: true }
})
</script>
