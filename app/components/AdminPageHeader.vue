<template>
  <div class="flex items-center justify-between mb-6">
    <div>
      <h1 class="text-2xl font-extrabold text-gray-800">{{ title }}</h1>
      <p v-if="subtitle" class="text-sm text-gray-500 mt-0.5">{{ subtitle }}</p>
    </div>
    <UButton color="green" icon="i-heroicons-plus" @click="$emit('add')">Tambah</UButton>
  </div>
</template>

<script setup>
defineProps({ title: String, subtitle: String })
defineEmits(['add'])
</script>
