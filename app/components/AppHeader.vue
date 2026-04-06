<template>
  <header class="fixed top-0 left-0 right-0 z-50 flex justify-center w-full pointer-events-none">
    <div class="w-full max-w-md bg-white shadow-sm h-16 flex items-center justify-between px-4 pointer-events-auto border-b border-gray-100">
      <NuxtLink to="/" class="flex items-center gap-2 transition-opacity hover:opacity-80">
        <UIcon name="i-heroicons-academic-cap" class="w-7 h-7 text-green-600" />
        <span class="font-bold text-lg text-gray-800 tracking-tight">Darul Maarif</span>
      </NuxtLink>
      <UButton
        color="green"
        variant="solid"
        size="sm"
        class="font-semibold rounded-full px-4 shadow-sm"
        to="/psb"
      >
        Daftar PSB
      </UButton>
    </div>
  </header>
</template>

<script setup>
// Header component logic
</script>
