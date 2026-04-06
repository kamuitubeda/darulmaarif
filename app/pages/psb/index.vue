<template>
  <div class="pb-10 space-y-8" v-if="data">
    
    <!-- 1. Hero Section -->
    <div class="bg-green-600 px-6 py-10 rounded-b-[40px] rounded-t-none sm:rounded-3xl text-white shadow-lg relative overflow-hidden isolate -mx-4 sm:mx-0 -mt-6 sm:mt-0">
      <div class="absolute -top-16 -right-16 w-48 h-48 bg-white/10 rounded-full blur-2xl pointer-events-none"></div>
      <div class="absolute -bottom-12 -left-12 w-40 h-40 bg-white/10 rounded-full blur-2xl pointer-events-none"></div>
      
      <div class="relative z-10 text-center flex flex-col items-center">
        <UIcon name="i-heroicons-academic-cap" class="w-14 h-14 text-green-200 mb-4 drop-shadow-md" />
        <h1 class="text-3xl font-extrabold mb-3 tracking-tight drop-shadow-sm">{{ data.hero.title }}</h1>
        <p class="text-sm text-green-50 font-medium mb-6 leading-relaxed max-w-sm">
          {{ data.hero.description }}
        </p>
        <UButton
          color="white"
          size="lg"
          class="rounded-xl shadow-md font-bold text-green-700 tracking-wide hover:scale-105 transition-transform"
          trailing-icon="i-heroicons-arrow-right"
          :to="data.hero.cta_link"
        >
          {{ data.hero.cta_text }}
        </UButton>
      </div>
    </div>

    <!-- 2. Registration Flow -->
    <div class="bg-white p-5 sm:p-6 rounded-2xl shadow-sm border border-gray-100">
      <h2 class="font-extrabold text-gray-800 text-lg mb-5 flex items-center gap-2">
        <UIcon name="i-heroicons-arrow-path-rounded-square" class="w-6 h-6 text-green-600" />
        {{ data.flow.title }}
      </h2>
      <div class="space-y-5">
         <div v-for="(step, index) in data.flow.steps" :key="index" class="flex gap-4">
            <div class="relative flex flex-col items-center">
               <div class="w-8 h-8 rounded-full bg-green-500 text-white flex items-center justify-center text-sm font-bold shrink-0 shadow-sm">{{ index + 1 }}</div>
               <div v-if="index !== data.flow.steps.length - 1" class="w-0.5 h-full bg-green-200 absolute top-8 mt-1"></div>
            </div>
            <div class="pb-2">
               <h3 class="font-bold text-sm sm:text-base text-gray-800">{{ step.title }}</h3>
               <p class="text-xs sm:text-sm text-gray-500 mt-1 leading-relaxed">{{ step.description }}</p>
            </div>
         </div>
      </div>
    </div>

    <!-- 3. Registration Requirements -->
    <div class="bg-gradient-to-br from-green-50 to-emerald-50 p-5 sm:p-6 rounded-2xl border border-green-100">
      <h2 class="font-extrabold text-green-800 text-lg mb-5 flex items-center gap-2">
        <UIcon name="i-heroicons-clipboard-document-check" class="w-6 h-6 text-green-600" />
        {{ data.requirements.title }}
      </h2>
      <ul class="space-y-3">
        <li v-for="(item, index) in data.requirements.items" :key="index" class="flex items-start gap-3 bg-white p-3 rounded-xl border border-green-100 shadow-sm">
          <UIcon name="i-heroicons-check-circle" class="w-5 h-5 text-green-500 shrink-0 mt-0.5" />
          <span class="text-xs sm:text-sm text-gray-700 font-medium leading-relaxed">{{ item }}</span>
        </li>
      </ul>
    </div>

    <!-- 4. Registration Fees -->
    <div>
      <h2 class="font-extrabold text-gray-800 text-lg mb-4 flex items-center gap-2 pl-1">
        <UIcon name="i-heroicons-banknotes" class="w-6 h-6 text-green-600" />
        {{ data.fees.title }}
      </h2>
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <div v-for="(pkg, index) in data.fees.packages" :key="index" class="bg-white p-5 rounded-2xl shadow-sm border border-gray-100 relative overflow-hidden">
          <div class="absolute top-0 right-0 p-3 opacity-10">
            <UIcon name="i-heroicons-currency-dollar" class="w-16 h-16 text-green-800" />
          </div>
          <h3 class="text-xs font-bold text-green-600 uppercase tracking-widest mb-1">{{ pkg.title }}</h3>
          <div class="text-xl sm:text-2xl font-extrabold text-gray-800 mb-3">{{ pkg.amount }}</div>
          <ul class="space-y-2">
            <li v-for="(detail, didx) in pkg.details" :key="didx" class="flex items-center gap-2 text-xs sm:text-sm text-gray-600">
              <UIcon name="i-heroicons-check" class="w-3 h-3 text-green-500" />
              {{ detail }}
            </li>
          </ul>
        </div>
      </div>
    </div>

    <!-- 5. Selection Schedule -->
    <div class="bg-white p-5 sm:p-6 rounded-2xl shadow-sm border border-gray-100">
      <h2 class="font-extrabold text-gray-800 text-lg mb-5 flex items-center gap-2">
        <UIcon name="i-heroicons-calendar-days" class="w-6 h-6 text-green-600" />
        {{ data.schedule.title }}
      </h2>
      <div class="space-y-4 relative pl-4 border-l-2 border-green-200 ml-2">
        <div v-for="(event, index) in data.schedule.events" :key="index" class="relative">
          <div class="absolute -left-[25px] top-1 w-4 h-4 bg-green-500 rounded-full border-[3px] border-white shadow-sm"></div>
          <div class="bg-gray-50 border border-gray-100 p-3 rounded-xl ml-2">
            <div class="text-[10px] font-bold text-green-600 uppercase mb-1">{{ event.date }}</div>
            <h3 class="font-bold text-sm text-gray-800 leading-tight">{{ event.event }}</h3>
          </div>
        </div>
      </div>
    </div>

    <!-- 6. FAQ Section -->
    <div class="bg-white p-5 sm:p-6 rounded-2xl shadow-sm border border-gray-100">
      <h2 class="font-extrabold text-gray-800 text-lg mb-5 flex items-center gap-2">
        <UIcon name="i-heroicons-question-mark-circle" class="w-6 h-6 text-green-600" />
        {{ data.faq.title }}
      </h2>
      <UAccordion 
        :items="data.faq.questions.map(q => ({ label: q.q, content: q.a }))" 
        color="green" 
        variant="soft"
        size="md"
        class="bg-gray-50 rounded-xl"
      />
    </div>

    <!-- 7. Final Call to Action -->
    <div class="bg-green-100 rounded-2xl p-6 text-center border border-green-200 shadow-sm relative overflow-hidden">
      <div class="absolute right-0 bottom-0 opacity-10 transform translate-x-1/4 translate-y-1/4">
        <UIcon name="i-heroicons-rocket-launch" class="w-40 h-40 text-green-800" />
      </div>
      <h2 class="text-lg sm:text-xl font-extrabold text-green-900 mb-4 relative z-10">{{ data.final_cta.title }}</h2>
      <UButton
        color="green"
        size="xl"
        class="rounded-xl shadow-md font-bold text-base tracking-wide px-8 relative z-10"
        trailing-icon="i-heroicons-arrow-right"
        :to="data.final_cta.cta_link"
      >
        {{ data.final_cta.cta_text }}
      </UButton>
    </div>

  </div>
  <div v-else-if="status === 'pending'" class="py-20 text-center">
    <!-- Loading State -->
    <UIcon name="i-heroicons-arrow-path" class="w-10 h-10 text-green-500 animate-spin mx-auto mb-4" />
    <p class="text-gray-500 font-medium">Memuat data...</p>
  </div>
  <div v-else class="py-20 text-center text-red-500">
    <UIcon name="i-heroicons-exclamation-triangle" class="w-10 h-10 mx-auto mb-4" />
    <p class="font-bold">Gagal memuat data konten.</p>
    <p class="text-xs mt-2">{{ error?.message || 'Data tidak ditemukan' }}</p>
  </div>
</template>

<script setup>
definePageMeta({
  title: 'PSB Landing Page - Darul Maarif'
})

const { data, status, error } = await useAsyncData('psb-landing', () => queryContent('/psb').findOne())
</script>
