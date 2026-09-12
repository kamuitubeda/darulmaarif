<template>
  <div>
    <AdminPageHeader title="Prestasi Santri" subtitle="Kelola daftar penghargaan dan capaian" @add="openModal(null)" />
    <UTable :rows="items" :columns="columns" :loading="pending" class="bg-white rounded-2xl shadow-sm border border-gray-100">
      <template #level-data="{ row }">
        <UBadge :color="levelColor(row.level)" variant="soft">{{ row.level }}</UBadge>
      </template>
      <template #actions-data="{ row }">
        <div class="flex gap-2">
          <UButton size="xs" icon="i-heroicons-pencil-square" color="gray" variant="ghost" @click="openModal(row)" />
          <UButton size="xs" icon="i-heroicons-trash" color="red" variant="ghost" @click="deleteItem(row.id)" />
        </div>
      </template>
    </UTable>

    <UModal v-model="isOpen">
      <UCard>
        <template #header><h3 class="font-bold">{{ form.id ? 'Edit' : 'Tambah' }} Prestasi</h3></template>
        <form class="space-y-4" @submit.prevent="saveItem">
          <UFormGroup label="Nama Prestasi/Lomba" required><UInput v-model="form.title" required /></UFormGroup>
          <UFormGroup label="Nama Santri" required><UInput v-model="form.name" required /></UFormGroup>
          <div class="grid grid-cols-2 gap-3">
            <UFormGroup label="Level">
              <USelect v-model="form.level" :options="['Nasional', 'Internasional', 'Provinsi', 'Kabupaten', 'Kecamatan']" />
            </UFormGroup>
            <UFormGroup label="Tahun"><UInput v-model="form.year" placeholder="2024" /></UFormGroup>
          </div>
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
const defaultForm = () => ({ id: null, title: '', name: '', level: 'Nasional', year: new Date().getFullYear().toString() })
const form = ref(defaultForm())
const columns = [
  { key: 'title', label: 'Prestasi' },
  { key: 'name', label: 'Nama Santri' },
  { key: 'level', label: 'Tingkat' },
  { key: 'year', label: 'Tahun' },
  { key: 'actions', label: '' },
]
const { data: items, pending, refresh } = await useAsyncData('admin-achievements', () =>
  supabase.from('achievements').select('*').order('created_at', { ascending: false }).then(r => r.data ?? [])
)
const levelColor = (l) => ({ Nasional: 'blue', Internasional: 'purple', Provinsi: 'green', Kabupaten: 'yellow', Kecamatan: 'gray' }[l] || 'gray')
const openModal = (row) => { form.value = row ? { ...row } : defaultForm(); isOpen.value = true }
const saveItem = async () => {
  saving.value = true
  const { id, ...data } = form.value
  if (id) await supabase.from('achievements').update(data).eq('id', id)
  else await supabase.from('achievements').insert(data)
  saving.value = false; isOpen.value = false; refresh()
}
const deleteItem = async (id) => { if (!confirm('Hapus prestasi ini?')) return; await supabase.from('achievements').delete().eq('id', id); refresh() }
</script>
