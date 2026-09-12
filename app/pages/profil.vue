<template>
  <div class="pb-10">

    <!-- Compact Header -->
    <div class="bg-gradient-to-br from-green-500 to-emerald-700 p-5 rounded-[2.5rem] shadow-lg mb-6 relative overflow-hidden isolate -mx-4 sm:mx-0">
      <div class="absolute -top-8 -right-8 w-32 h-32 bg-white/10 rounded-full blur-2xl pointer-events-none"></div>
      <UIcon name="i-heroicons-building-library" class="absolute -right-4 -bottom-4 w-28 h-28 text-white/10 rotate-12 pointer-events-none" />
      <div class="relative z-10 flex items-center gap-4">
        <div class="w-14 h-14 bg-white/20 backdrop-blur-md rounded-2xl flex items-center justify-center border border-white/30 shadow-inner shrink-0">
          <UIcon name="i-heroicons-building-library" class="w-7 h-7 text-white" />
        </div>
        <div>
          <h1 class="text-xl font-extrabold text-white tracking-tight leading-tight">Profil Pesantren</h1>
          <p class="text-green-100 text-xs font-medium mt-0.5">Pondok Pesantren Darul Maarif</p>
        </div>
      </div>
    </div>

    <!-- 1. Mudirul Ma'had -->
    <div class="mb-5" v-if="profile">
      <div class="flex items-center gap-2.5 mb-3 px-1">
        <div class="w-1 h-5 bg-green-500 rounded-full shrink-0"></div>
        <UIcon name="i-heroicons-user-circle" class="w-4 h-4 text-green-600 shrink-0" />
        <h2 class="font-extrabold text-gray-800 text-sm tracking-tight">Mudirul Ma'had</h2>
      </div>
      <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-5 flex items-center gap-4">
        <UAvatar :src="profile.kyai_photo_url || 'https://picsum.photos/seed/kyai/200/200'" size="2xl" class="ring-2 ring-green-200 shrink-0" />
        <div>
          <h3 class="font-extrabold text-gray-800 text-base leading-tight">{{ profile.kyai_name }}</h3>
          <p class="text-xs text-green-600 font-bold mt-0.5 mb-2">{{ profile.kyai_title }}</p>
        </div>
      </div>
    </div>

    <!-- 2. Sejarah Singkat -->
    <div class="mb-5" v-if="profile">
      <div class="flex items-center gap-2.5 mb-3 px-1">
        <div class="w-1 h-5 bg-green-500 rounded-full shrink-0"></div>
        <UIcon name="i-heroicons-book-open" class="w-4 h-4 text-green-600 shrink-0" />
        <h2 class="font-extrabold text-gray-800 text-sm tracking-tight">Sejarah Singkat</h2>
      </div>
      <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
        <img src="https://picsum.photos/seed/pesantren_profil/800/400" class="w-full h-40 object-cover" alt="Gedung Pesantren" />
        <div class="p-5">
          <p class="text-sm text-gray-600 leading-relaxed text-justify whitespace-pre-wrap">{{ profile.history }}</p>
        </div>
      </div>
    </div>

    <!-- 3. Visi & Misi -->
    <div class="mb-5" v-if="profile">
      <div class="flex items-center gap-2.5 mb-3 px-1">
        <div class="w-1 h-5 bg-green-500 rounded-full shrink-0"></div>
        <UIcon name="i-heroicons-light-bulb" class="w-4 h-4 text-green-600 shrink-0" />
        <h2 class="font-extrabold text-gray-800 text-sm tracking-tight">Visi & Misi</h2>
      </div>
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
        <div class="bg-green-50 p-4 rounded-2xl border border-green-100">
          <div class="w-9 h-9 bg-green-100 rounded-xl flex items-center justify-center mb-3">
            <UIcon name="i-heroicons-eye" class="w-5 h-5 text-green-600" />
          </div>
          <h3 class="font-extrabold text-gray-800 text-sm mb-1">Visi</h3>
          <p class="text-xs text-gray-600 leading-relaxed whitespace-pre-wrap">{{ profile.vision }}</p>
        </div>
        <div class="bg-blue-50 p-4 rounded-2xl border border-blue-100">
          <div class="w-9 h-9 bg-blue-100 rounded-xl flex items-center justify-center mb-3">
            <UIcon name="i-heroicons-paper-airplane" class="w-5 h-5 text-blue-600" />
          </div>
          <h3 class="font-extrabold text-gray-800 text-sm mb-1">Misi</h3>
          <p class="text-xs text-gray-600 leading-relaxed whitespace-pre-wrap">{{ profile.mission }}</p>
        </div>
      </div>
    </div>

    <!-- 4. Jadwal Kegiatan Harian -->
    <div class="mb-2">
      <div class="flex items-center gap-2.5 mb-3 px-1">
        <div class="w-1 h-5 bg-green-500 rounded-full shrink-0"></div>
        <UIcon name="i-heroicons-clock" class="w-4 h-4 text-green-600 shrink-0" />
        <h2 class="font-extrabold text-gray-800 text-sm tracking-tight">Jadwal Kegiatan Harian</h2>
      </div>
      <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden divide-y divide-gray-50">
        <div
          v-for="(item, i) in schedule"
          :key="i"
          class="flex items-center gap-3 px-4 py-3"
          :class="item.highlight ? 'bg-green-50/70' : ''"
        >
          <div class="shrink-0 w-24 text-right">
            <span class="text-[10px] font-bold tabular-nums" :class="item.highlight ? 'text-green-600' : 'text-gray-400'">
              {{ item.time }}
            </span>
          </div>
          <div class="w-2 h-2 rounded-full shrink-0" :class="item.highlight ? 'bg-green-500 ring-2 ring-green-200' : 'bg-gray-200'"></div>
          <p class="text-xs leading-snug" :class="item.highlight ? 'font-bold text-green-800' : 'font-medium text-gray-700'">
            {{ item.name }}
          </p>
        </div>
      </div>
    </div>

  </div>
</template>

<script setup>
definePageMeta({ title: 'Profil Pesantren - Darul Maarif' })

const supabase = useSupabaseClient()
const { data: profile } = await useAsyncData('public-profile', () =>
  supabase.from('site_profile').select('*').eq('id', 1).single().then(r => r.data)
)

const schedule = [
  { time: '03.30 – 04.00', name: 'Sholat Tahajud Berjamaah', highlight: true },
  { time: '04.00 – 04.30', name: 'Sholat Subuh Berjamaah', highlight: true },
  { time: '04.45 – 06.00', name: 'Mengaji & Setoran Hafalan Al-Qur\'an (Sorogan)', highlight: false },
  { time: '06.00 – 07.00', name: 'Bersih-Bersih & Persiapan Sekolah', highlight: false },
  { time: '07.00 – 07.15', name: 'Sholat Dhuha Berjamaah', highlight: true },
  { time: '07.30 – 12.00', name: 'Sekolah (KBM Formal)', highlight: false },
  { time: '12.00 – 12.30', name: 'Sholat Dhuhur & Istighotsah Berjamaah', highlight: true },
  { time: '13.00 – 14.30', name: 'Lanjut Sekolah', highlight: false },
  { time: '14.30 – 15.30', name: 'Istirahat', highlight: false },
  { time: '15.30 – 15.45', name: 'Sholat Ashar Berjamaah', highlight: true },
  { time: '15.45 – 16.00', name: 'Mengaji Al-Qur\'an Bandongan', highlight: false },
  { time: '16.30 – 17.20', name: 'Setoran Hafalan Al-Qur\'an', highlight: false },
  { time: '17.30 – 18.00', name: 'Sholat Maghrib Berjamaah', highlight: true },
  { time: '18.00 – 19.00', name: 'Mengaji Kitab', highlight: false },
  { time: '19.00 – 19.20', name: 'Jamaah Sholat Isya\'', highlight: true },
  { time: '19.20 – 19.30', name: 'Lalaran Alfiyah (Amtsilati)', highlight: false },
  { time: '19.30 – 21.00', name: 'Belajar Mandiri', highlight: false },
  { time: '21.00 – 21.20', name: 'Dzikir Malam (Ratibul Haddad)', highlight: true },
  { time: '21.20 – 21.50', name: 'Jam Tambahan Setoran Hafalan Al-Qur\'an', highlight: false },
  { time: '22.00 – 03.30', name: 'Istirahat', highlight: false },
]
</script>
