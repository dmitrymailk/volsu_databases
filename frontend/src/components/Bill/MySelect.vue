<template>
  <div class="my-select">
    <ul class="list-group">
      <li class="list-group-item">
        {{ displayedName }}

        <i
          style="width: 16px; height: 16px; cursor: pointer"
          class="bi bi-arrow-down-circle-fill"
          @click="showSelectList"
        ></i>
      </li>
    </ul>
    <ul class="list-group my-select__drop-list" v-if="optionsIsOpen">
      <li class="list-group-item" v-for="(option, index) in optionsList">
        <div class="form-check">
          <input
            class="form-check-input"
            type="radio"
            name="flexRadioDefault"
            @click="() => selectEvent(option)"
          />
          <label class="form-check-label">
            {{ displayFormatFunction(option) }}
          </label>
        </div>
      </li>
    </ul>
  </div>
</template>
<script>
export default {
  props: [
    "selectCallback",
    "dataCallback",
    "defaultDisplayName",
    "defaultOption",
    "displayFormatFunction",
  ],
  data() {
    return {
      optionsIsOpen: false,
      optionsList: [],
      displayedName: "",
    };
  },
  mounted() {
    const defaultOption = this.defaultOption;
    // this.displayedName = this.defaultDisplayName(defaultOption);
    this.displayedName = this.defaultDisplayName;
  },
  methods: {
    selectEvent(option) {
      this.displayedName = this.displayFormatFunction(option);
      this.selectCallback(option);
      this.optionsIsOpen = !this.optionsIsOpen;
    },
    async showSelectList() {
      console.log("show");
      if (!this.optionsIsOpen) {
        this.optionsList = await this.dataCallback();
      }
      this.optionsIsOpen = !this.optionsIsOpen;
    },
  },
};
</script>

<style scoped lang="sass">
.my-select
  &__drop-list
    position: absolute
    z-index: 1
</style>
