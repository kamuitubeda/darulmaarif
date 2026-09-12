<template>
  <div>
    <div class="mb-6">
      <h1 class="text-2xl font-extrabold text-gray-800">Informasi Kontak</h1>
      <p class="text-sm text-gray-500 mt-1">Edit informasi kontak yang tampil di portal</p>
    </div>

    <UAlert v-if="saved" icon="i-heroicons-check-circle" color="green" variant="soft" title="Perubahan berhasil disimpan!" class="mb-4" />

    <form class="space-y-4" @submit.prevent="saveContact">
      <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-5 space-y-4">
        <h2 class="font-bold text-gray-800 flex items-center gap-2 mb-2">
          <UIcon name="i-heroicons-phone" class="w-4 h-4 text-green-600" /> Saluran Komunikasi
        </h2>
        <UFormGroup label="Nomor Telepon"><UInput v-model="form.phone" placeholder="(022) 1234-567" icon="i-heroicons-phone" /></UFormGroup>
        <UFormGroup label="WhatsApp (format: 628xxx)"><UInput v-model="form.whatsapp" placeholder="6281234567890" icon="i-heroicons-device-phone-mobile" /></UFormGroup>
        <UFormGroup label="Email"><UInput v-model="form.email" type="email" placeholder="info@darulmaarif.sch.id" icon="i-heroicons-envelope" /></UFormGroup>
        <UFormGroup label="Instagram (username)"><UInput v-model="form.instagram" placeholder="@darulmaarif.official" icon="i-heroicons-camera" /></UFormGroup>
      </div>

      <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-5">
        <h2 class="font-bold text-gray-800 flex items-center gap-2 mb-4">
          <UIcon name="i-heroicons-map-pin" class="w-4 h-4 text-green-600" /> Lokasi
        </h2>
        <UFormGroup label="Alamat Lengkap">
          <UTextarea v-model="form.address" autoresize />
        </UFormGroup>
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
const form = ref({ phone: '', whatsapp: '', email: '', instagram: '', address: '' })

const { data } = await useAsyncData('admin-contacts', () =>
  supabase.from('contacts').select('*').eq('id', 1).single().then(r => r.data)
)
if (data.value) Object.assign(form.value, data.value)

const saveContact = async () => {
  saving.value = true
  await supabase.from('contacts').update({ ...form.value, updated_at: new Date().toISOString() }).eq('id', 1)
  saving.value = false
  saved.value = true
  setTimeout(() => saved.value = false, 3000)
}
</script>
