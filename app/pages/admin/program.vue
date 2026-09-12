<template>
  <div>
    <AdminPageHeader title="Program Pendidikan" subtitle="Kelola program unggulan pesantren" @add="openModal(null)" />
    <div class="space-y-3">
      <div v-for="item in items" :key="item.id" class="bg-white rounded-2xl shadow-sm border border-gray-100 p-4 flex items-center gap-4">
        <div class="w-11 h-11 rounded-xl flex items-center justify-center text-white shrink-0" :class="item.color || 'bg-green-500'">
          <UIcon :name="item.icon || 'i-heroicons-academic-cap'" class="w-6 h-6" />
        </div>
        <div class="flex-1 min-w-0">
          <h3 class="font-bold text-gray-800 text-sm">{{ item.title }}</h3>
          <p class="text-xs text-gray-500 line-clamp-1 mt-0.5">{{ item.description }}</p>
        </div>
        <div class="flex gap-2 shrink-0">
          <UButton size="xs" icon="i-heroicons-pencil-square" color="gray" variant="ghost" @click="openModal(item)" />
          <UButton size="xs" icon="i-heroicons-trash" color="red" variant="ghost" @click="deleteItem(item.id)" />
        </div>
      </div>
      <div v-if="pending" v-for="n in 3" :key="n" class="h-16 bg-gray-100 rounded-2xl animate-pulse"></div>
    </div>

    <UModal v-model="isOpen">
      <UCard>
        <template #header><h3 class="font-bold">{{ form.id ? 'Edit' : 'Tambah' }} Program</h3></template>
        <form class="space-y-4" @submit.prevent="saveItem">
          <UFormGroup label="Nama Program" required><UInput v-model="form.title" required /></UFormGroup>
          <UFormGroup label="Deskripsi"><UTextarea v-model="form.description" autoresize /></UFormGroup>
          <div class="grid grid-cols-2 gap-3">
            <UFormGroup label="Ikon (Heroicons)"><UInput v-model="form.icon" placeholder="i-heroicons-book-open" /></UFormGroup>
            <UFormGroup label="Warna (Tailwind)"><UInput v-model="form.color" placeholder="bg-green-500" /></UFormGroup>
          </div>
          <UFormGroup label="Status"><UToggle v-model="form.is_active" label="Tampilkan di portal" /></UFormGroup>
          <div class="flex justify-end gap-2">
            <UButton color="gray" variant="ghost" @click="isOpen = false">Batal</UButton>
            <UButton type="submit" color="green" :loading="saving">Simpan</UButton>
          </div>
        </form>
      </UCard>
    </UModal>
  </div>
</template>

<script setup>
definePageMeta({ layout: 'admin', middleware: 'auth' })
const supabase = useSupabaseClient()
const isOpen = ref(false)
const saving = ref(false)
const defaultForm = () => ({ id: null, title: '', description: '', icon: 'i-heroicons-book-open', color: 'bg-green-500', is_active: true })
const form = ref(defaultForm())
const { data: items, pending, refresh } = await useAsyncData('admin-programs', () =>
  supabase.from('programs').select('*').order('sort_order').then(r => r.data ?? [])
)
const openModal = (row) => { form.value = row ? { ...row } : defaultForm(); isOpen.value = true }
const saveItem = async () => {
  saving.value = true
  const { id, ...data } = form.value
  if (id) await supabase.from('programs').update(data).eq('id', id)
  else await supabase.from('programs').insert(data)
  saving.value = false; isOpen.value = false; refresh()
}
const deleteItem = async (id) => { if (!confirm('Hapus program ini?')) return; await supabase.from('programs').delete().eq('id', id); refresh() }
</script>
