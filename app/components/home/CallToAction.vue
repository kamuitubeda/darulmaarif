<template>
  <div class="mb-2">
    <div class="relative overflow-hidden rounded-2xl bg-green-600 text-white shadow-lg">
      <!-- Decorative background -->
      <div class="absolute top-0 right-0 -mr-8 -mt-8 w-32 h-32 rounded-full bg-white/10 blur-2xl"></div>
      <div class="absolute bottom-0 left-0 -ml-8 -mb-8 w-24 h-24 rounded-full bg-green-400/20 blur-xl"></div>
      
      <div class="relative p-5 sm:p-6 flex flex-col items-center text-center">
        <div class="bg-white/20 p-3 rounded-full mb-3">
          <UIcon name="i-heroicons-academic-cap" class="w-8 h-8 text-white" />
        </div>
        
        <h3 class="text-lg font-bold mb-1">Penerimaan Santri Baru</h3>
        <p class="text-xs sm:text-sm text-green-100 font-medium mb-4 leading-relaxed">
          Mari bergabung bersama kami membentuk generasi Qur'ani yang berakhlak mulia.
        </p>
        
        <UButton
          color="white"
          variant="solid"
          size="md"
          class="font-bold w-full justify-center rounded-xl text-green-600 shadow-sm"
          trailing-icon="i-heroicons-arrow-right"
        >
          Daftar Sekarang
        </UButton>
      </div>
    </div>
  </div>
</template>
