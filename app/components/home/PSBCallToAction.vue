<template>
  <div class="mb-4">
    <div class="relative overflow-hidden rounded-3xl bg-gradient-to-br from-green-600 to-emerald-700 text-white shadow-xl isolate">
      <!-- High impact decorative background patterns -->
      <div class="absolute -top-12 -right-12 w-40 h-40 rounded-full bg-white/10 blur-2xl z-0 mix-blend-overlay pointer-events-none"></div>
      <div class="absolute -bottom-16 -left-12 w-48 h-48 rounded-full bg-emerald-400/30 blur-2xl z-0 mix-blend-overlay pointer-events-none"></div>
      
      <!-- Content geometry -->
      <div class="relative z-10 p-6 sm:p-8 flex flex-col items-center text-center">
        <!-- Visual anchor -->
        <div class="bg-white/10 backdrop-blur-sm p-4 rounded-full mb-4 border border-white/20 shadow-inner">
          <UIcon name="i-heroicons-academic-cap" class="w-10 h-10 text-white" />
        </div>
        
        <h2 class="text-xl sm:text-2xl font-extrabold mb-2 tracking-tight drop-shadow-sm">Penerimaan Santri Baru</h2>
        
        <p class="text-sm text-green-50/90 font-medium mb-6 leading-relaxed max-w-sm">
          Mari melangkah bersama membentuk generasi robbani yang mandiri, berilmu, dan berakhlak mulia. Pendaftaran tahun ajaran baru telah dibuka.
        </p>
        
        <!-- Call to action buttons row -->
        <div class="flex flex-col sm:flex-row w-full gap-3 mt-auto">
          <UButton
            color="white"
            variant="solid"
            size="lg"
            class="font-bold w-full sm:flex-1 justify-center rounded-xl text-green-700 hover:text-green-800 shadow-md transform active:scale-95 transition-transform"
            trailing-icon="i-heroicons-rocket-launch"
            to="/psb"
          >
            Daftar Sekarang
          </UButton>
          
          <UButton
            color="white"
            variant="ghost"
            size="lg"
            class="font-semibold w-full sm:flex-1 justify-center rounded-xl text-white bg-white/10 hover:bg-white/20 backdrop-blur-sm ring-1 ring-white/30 transform active:scale-95 transition-transform"
            to="/program"
          >
            Pelajari Program
          </UButton>
        </div>
      </div>
    </div>
  </div>
</template>
