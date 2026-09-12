<template>
  <div>
    <AdminPageHeader 
      title="Sesi & Rekap Absensi" 
      description="Buat sesi absensi harian atau event khusus, dan lihat laporan kehadirannya."
      icon="i-heroicons-check-badge"
    >
      <template #actions>
        <UButton color="green" icon="i-heroicons-play" disabled>
          Buka Sesi Absensi Baru
        </UButton>
      </template>
    </AdminPageHeader>

    <UCard>
      <div class="text-center py-10">
        <UIcon name="i-heroicons-wrench-screwdriver" class="w-16 h-16 text-gray-300 mx-auto mb-4" />
        <h3 class="text-lg font-bold text-gray-800 mb-2">Modul Absensi Tahap 2</h3>
        <p class="text-gray-500 text-sm max-w-lg mx-auto">
          Fitur pembuatan sesi absensi dan pengisian form kehadiran per-kelas saat ini sedang dalam antrean pengembangan (Tahap 2). 
          Silakan lengkapi Data Santri dan Master Event Absensi terlebih dahulu.
        </p>
      </div>
    </UCard>
  </div>
</template>

<script setup>
useHead({
  title: `Sesi Absensi - Admin Darul Maarif`
})
</script>
