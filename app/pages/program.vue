<template>
  <div class="pb-10">
    <!-- Compact Header -->
    <div class="bg-gradient-to-br from-green-500 to-emerald-700 p-5 rounded-[2.5rem] shadow-lg mb-6 relative overflow-hidden isolate -mx-4 sm:mx-0">
      <div class="absolute -top-8 -right-8 w-32 h-32 bg-white/10 rounded-full blur-2xl pointer-events-none"></div>
      <UIcon name="i-heroicons-academic-cap" class="absolute -right-4 -bottom-4 w-28 h-28 text-white/10 rotate-12 pointer-events-none" />
      <div class="relative z-10 flex items-center gap-4">
        <div class="w-14 h-14 bg-white/20 backdrop-blur-md rounded-2xl flex items-center justify-center border border-white/30 shadow-inner shrink-0">
          <UIcon name="i-heroicons-academic-cap" class="w-7 h-7 text-white" />
        </div>
        <div>
          <h1 class="text-xl font-extrabold text-white tracking-tight leading-tight">Program Pendidikan</h1>
          <p class="text-green-100 text-xs font-medium mt-0.5">Kurikulum unggulan Darul Maarif.</p>
        </div>
      </div>
    </div>

    <div class="space-y-4">
      <div v-for="(program, index) in programs" :key="index" class="bg-white rounded-2xl shadow-sm border border-gray-100 p-5 relative overflow-hidden">
        <div :class="`absolute top-0 right-0 w-16 h-16 opacity-10 rounded-bl-full ${program.color}`"></div>
        <div class="flex items-start gap-4">
          <div :class="`w-12 h-12 rounded-xl flex items-center justify-center text-white shrink-0 ${program.color}`">
            <UIcon :name="program.icon" class="w-6 h-6" />
          </div>
          <div>
            <h3 class="font-bold text-gray-800 text-lg mb-1">{{ program.title }}</h3>
            <p class="text-sm text-gray-600 leading-relaxed mb-3">{{ program.description }}</p>
            <div class="flex gap-2">
               <span v-for="lvl in program.levels" :key="lvl" class="text-[10px] font-semibold text-green-700 bg-green-50 px-2 py-1 rounded border border-green-100">
                 {{ lvl }}
               </span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
definePageMeta({
  title: 'Program Pendidikan - Darul Maarif'
})

const supabase = useSupabaseClient()

const { data: programs, pending } = await useAsyncData('public-programs', () =>
  supabase.from('programs').select('*').eq('is_active', true).order('sort_order').then(r => r.data ?? [])
)
</script>
