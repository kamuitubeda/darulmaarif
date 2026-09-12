<template>
  <div>
    <div class="mb-6">
      <h1 class="text-2xl font-extrabold text-gray-800">Profil Pesantren</h1>
      <p class="text-sm text-gray-500 mt-1">Edit informasi dasar dan pimpinan pesantren</p>
    </div>

    <UAlert v-if="saved" icon="i-heroicons-check-circle" color="green" variant="soft" title="Perubahan berhasil disimpan!" class="mb-4" />

    <form class="space-y-4" @submit.prevent="saveProfile">
      <!-- Mudirul Ma'had -->
      <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-5">
        <h2 class="font-bold text-gray-800 mb-4 flex items-center gap-2">
          <UIcon name="i-heroicons-user-circle" class="w-4 h-4 text-green-600" /> Mudirul Ma'had
        </h2>
        <div class="space-y-3">
          <UFormGroup label="Nama Lengkap"><UInput v-model="form.kyai_name" /></UFormGroup>
          <UFormGroup label="Gelar/Jabatan"><UInput v-model="form.kyai_title" placeholder="Pengasuh & Pimpinan" /></UFormGroup>
          <UFormGroup label="URL Foto Kyai"><UInput v-model="form.kyai_photo_url" placeholder="https://..." /></UFormGroup>
        </div>
      </div>

      <!-- Sejarah -->
      <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-5">
        <h2 class="font-bold text-gray-800 mb-4 flex items-center gap-2">
          <UIcon name="i-heroicons-book-open" class="w-4 h-4 text-green-600" /> Sejarah Singkat
        </h2>
        <UTextarea v-model="form.history" :rows="5" autoresize />
      </div>

      <!-- Visi Misi -->
      <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-5">
        <h2 class="font-bold text-gray-800 mb-4 flex items-center gap-2">
          <UIcon name="i-heroicons-light-bulb" class="w-4 h-4 text-green-600" /> Visi & Misi
        </h2>
        <div class="space-y-3">
          <UFormGroup label="Visi"><UTextarea v-model="form.vision" autoresize /></UFormGroup>
          <UFormGroup label="Misi"><UTextarea v-model="form.mission" autoresize /></UFormGroup>
        </div>
      </div>

      <UButton type="submit" color="green" size="lg" :loading="saving" icon="i-heroicons-cloud-arrow-up">
        Simpan Perubahan
      </UButton>
    </form>
  </div>
</template>

<script setup>
definePageMeta({ layout: 'admin', middleware: 'auth' })
const supabase = useSupabaseClient()
const saving = ref(false)
const saved = ref(false)
const form = ref({ kyai_name: '', kyai_title: '', kyai_photo_url: '', history: '', vision: '', mission: '' })

const { data } = await useAsyncData('admin-profile', () =>
  supabase.from('site_profile').select('*').eq('id', 1).single().then(r => r.data)
)
if (data.value) Object.assign(form.value, data.value)

const saveProfile = async () => {
  saving.value = true
  await supabase.from('site_profile').update({ ...form.value, updated_at: new Date().toISOString() }).eq('id', 1)
  saving.value = false
  saved.value = true
  setTimeout(() => saved.value = false, 3000)
}
</script>
