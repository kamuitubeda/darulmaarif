<template>
  <div class="pb-8 pt-6 relative min-h-screen flex flex-col items-center justify-center -mt-8">
    
    <!-- Success Graphic -->
    <div class="relative mb-6">
      <div class="absolute inset-0 bg-green-200 rounded-full blur-2xl opacity-50 scale-150 animate-pulse"></div>
      <div class="w-24 h-24 bg-gradient-to-tr from-green-500 to-emerald-400 rounded-full flex items-center justify-center relative z-10 shadow-lg border-4 border-white">
        <UIcon name="i-heroicons-check" class="w-12 h-12 text-white drop-shadow-md" />
      </div>
    </div>
    
    <!-- Congratulations Text -->
    <h2 class="text-2xl font-extrabold text-gray-800 tracking-tight mb-2 text-center">Pendaftaran Berhasil!</h2>
    <p class="text-sm text-gray-500 text-center max-w-xs mb-8 leading-relaxed">
      Alhamdulillah, data calon santri dan berkas persyaratan telah berhasil disimpan secara aman.
    </p>

    <!-- Information Card -->
    <div class="bg-gray-50 p-5 rounded-2xl border border-gray-100 max-w-sm w-full mb-8 shadow-sm">
      <h3 class="font-bold text-gray-800 text-sm mb-3">Langkah Selanjutnya:</h3>
      <ul class="space-y-3">
        <li class="flex items-start gap-3">
          <div class="w-6 h-6 rounded-full bg-blue-100 text-blue-600 flex items-center justify-center shrink-0 mt-0.5">
            <UIcon name="i-heroicons-clock" class="w-4 h-4" />
          </div>
          <p class="text-xs text-gray-600 pt-1 leading-snug">Tim Verifikator akan memeriksa validitas berkas (maks. 2x24 jam).</p>
        </li>
        <li class="flex items-start gap-3">
          <div class="w-6 h-6 rounded-full bg-green-100 text-green-600 flex items-center justify-center shrink-0 mt-0.5">
            <UIcon name="i-heroicons-chat-bubble-oval-left-ellipsis" class="w-4 h-4" />
          </div>
          <p class="text-xs text-gray-600 pt-1 leading-snug">Jadwal wawancara akan kami kirimkan via WhatsApp Orang Tua.</p>
        </li>
      </ul>
    </div>

    <!-- Actions -->
    <div class="flex flex-col w-full gap-3 max-w-sm">
      <UButton
        block
        color="green"
        size="lg"
        class="rounded-xl shadow-sm font-bold text-sm tracking-wide"
        to="/psb"
      >
        Kembali ke Beranda PSB
      </UButton>
      <UButton
        block
        color="gray"
        variant="ghost"
        size="lg"
        class="rounded-xl font-bold text-sm"
        to="/"
      >
        Halaman Utama
      </UButton>
    </div>
    
  </div>
</template>

<script setup>
definePageMeta({
  title: 'Pendaftaran Berhasil - Darul Maarif'
})
</script>

<style scoped>
/* Optional pulsing animations */
</style>
