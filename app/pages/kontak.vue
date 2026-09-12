<template>
  <div class="pb-10">

    <!-- Compact Header — konsisten dengan halaman lain -->
    <div class="bg-gradient-to-br from-green-500 to-emerald-700 p-5 rounded-[2.5rem] shadow-lg mb-6 relative overflow-hidden isolate -mx-4 sm:mx-0">
      <div class="absolute -top-8 -right-8 w-32 h-32 bg-white/10 rounded-full blur-2xl pointer-events-none"></div>
      <UIcon name="i-heroicons-map-pin" class="absolute -right-4 -bottom-4 w-28 h-28 text-white/10 rotate-12 pointer-events-none" />
      <div class="relative z-10 flex items-center gap-4">
        <div class="w-14 h-14 bg-white/20 backdrop-blur-md rounded-2xl flex items-center justify-center border border-white/30 shadow-inner shrink-0">
          <UIcon name="i-heroicons-map-pin" class="w-7 h-7 text-white" />
        </div>
        <div>
          <h1 class="text-xl font-extrabold text-white tracking-tight leading-tight">Hubungi Kami</h1>
          <p class="text-green-100 text-xs font-medium mt-0.5">Kami siap melayani pertanyaan Anda.</p>
        </div>
      </div>
    </div>

    <!-- Map Placeholder -->
    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden mb-6">
      <div class="relative h-40 bg-gray-100 overflow-hidden">
        <img src="https://picsum.photos/seed/pesantren_map/800/320" class="w-full h-full object-cover" alt="Lokasi Pesantren" />
        <div class="absolute inset-0 bg-black/20 flex items-center justify-center">
          <div class="bg-white px-4 py-2 rounded-full shadow-md flex items-center gap-2">
            <UIcon name="i-heroicons-map-pin" class="w-4 h-4 text-red-500" />
            <span class="text-xs font-bold text-gray-700">Lihat di Google Maps</span>
          </div>
        </div>
      </div>
      <div class="p-4">
        <h3 class="font-bold text-gray-800 mb-0.5">Pondok Pesantren Darul Maarif</h3>
        <p class="text-sm text-gray-500">{{ contact?.address }}</p>
      </div>
    </div>

    <!-- Contact Actions -->
    <h3 class="font-bold text-gray-700 text-xs uppercase tracking-widest mb-3 px-1">Saluran Komunikasi</h3>
    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden divide-y divide-gray-50 mb-6">
      <a :href="contact ? `tel:${contact.phone.replace(/\\D/g, '')}` : '#'" class="flex items-center gap-4 p-4 group active:bg-gray-50 transition-colors">
        <div class="w-11 h-11 rounded-xl bg-green-50 flex items-center justify-center shrink-0 group-hover:bg-green-100 transition-colors">
          <UIcon name="i-heroicons-phone" class="w-5 h-5 text-green-600" />
        </div>
        <div class="flex-1">
          <div class="text-sm font-bold text-gray-800">Telepon Pondok</div>
          <div class="text-xs text-gray-500">{{ contact?.phone }}</div>
        </div>
        <UIcon name="i-heroicons-chevron-right" class="w-4 h-4 text-gray-300 group-hover:text-green-500 transition-colors" />
      </a>

      <a :href="contact ? `https://wa.me/${contact.whatsapp}` : '#'" target="_blank" class="flex items-center gap-4 p-4 group active:bg-gray-50 transition-colors">
        <div class="w-11 h-11 rounded-xl bg-emerald-50 flex items-center justify-center shrink-0 group-hover:bg-emerald-100 transition-colors">
          <UIcon name="i-heroicons-device-phone-mobile" class="w-5 h-5 text-emerald-600" />
        </div>
        <div class="flex-1">
          <div class="text-sm font-bold text-gray-800">WhatsApp Admin</div>
          <div class="text-xs text-gray-500">+{{ contact?.whatsapp }}</div>
        </div>
        <UIcon name="i-heroicons-chevron-right" class="w-4 h-4 text-gray-300 group-hover:text-green-500 transition-colors" />
      </a>

      <a :href="contact ? `mailto:${contact.email}` : '#'" class="flex items-center gap-4 p-4 group active:bg-gray-50 transition-colors">
        <div class="w-11 h-11 rounded-xl bg-blue-50 flex items-center justify-center shrink-0 group-hover:bg-blue-100 transition-colors">
          <UIcon name="i-heroicons-envelope" class="w-5 h-5 text-blue-600" />
        </div>
        <div class="flex-1">
          <div class="text-sm font-bold text-gray-800">Email</div>
          <div class="text-xs text-gray-500">{{ contact?.email }}</div>
        </div>
        <UIcon name="i-heroicons-chevron-right" class="w-4 h-4 text-gray-300 group-hover:text-green-500 transition-colors" />
      </a>

      <a :href="contact ? `https://instagram.com/${contact.instagram.replace('@', '')}` : '#'" target="_blank" class="flex items-center gap-4 p-4 group active:bg-gray-50 transition-colors">
        <div class="w-11 h-11 rounded-xl bg-pink-50 flex items-center justify-center shrink-0 group-hover:bg-pink-100 transition-colors">
          <UIcon name="i-heroicons-camera" class="w-5 h-5 text-pink-600" />
        </div>
        <div class="flex-1">
          <div class="text-sm font-bold text-gray-800">Instagram</div>
          <div class="text-xs text-gray-500">{{ contact?.instagram }}</div>
        </div>
        <UIcon name="i-heroicons-chevron-right" class="w-4 h-4 text-gray-300 group-hover:text-green-500 transition-colors" />
      </a>
    </div>

    <!-- Office Hours -->
    <h3 class="font-bold text-gray-700 text-xs uppercase tracking-widest mb-3 px-1">Jam Operasional</h3>
    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-4 space-y-3">
      <div v-for="item in hours" :key="item.day" class="flex justify-between items-center">
        <span class="text-sm font-semibold text-gray-700">{{ item.day }}</span>
        <span class="text-sm font-bold" :class="item.open ? 'text-green-600' : 'text-gray-400'">{{ item.time }}</span>
      </div>
    </div>

  </div>
</template>

<script setup>
definePageMeta({ title: 'Kontak - Darul Maarif' })
const supabase = useSupabaseClient()
const { data: contact } = await useAsyncData('public-contact', () =>
  supabase.from('contacts').select('*').eq('id', 1).single().then(r => r.data)
)
const hours = [
  { day: 'Senin – Kamis', time: '08.00 – 15.00 WIB', open: true },
  { day: 'Jumat', time: '08.00 – 11.30 WIB', open: true },
  { day: 'Sabtu', time: '08.00 – 12.00 WIB', open: true },
  { day: 'Minggu / Libur', time: 'Tutup', open: false },
]
</script>
