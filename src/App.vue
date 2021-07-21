<template>
  <div id="root">
    <start-modal
      @to-start="handleStart"
      @to-rank="handleRank"
      v-if="!isGameStart && !showRanking"
    />
    <game v-if="isGameStart" @exit="handleGameExit" />
    <global-ranking v-if="showRanking" @exit="handleRankExit" />
  </div>
</template>

<script>
import Game from "./components/Game.vue";
import GlobalRanking from "./components/GlobalRanking.vue";
import StartModal from "./components/StartModal.vue";

export default {
  components: { StartModal, Game, GlobalRanking },

  data() {
    return {
      isGameStart: false,
      showRanking: false,
    };
  },

  methods: {
    async handleStart() {
      this.isGameStart = true;
    },

    async handleRank() {
      this.showRanking = true;
    },

    async handleGameExit() {
      this.isGameStart = false;
    },

    handleRankExit() {
      this.showRanking = false;
      this.isGameStart = false;
    },
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  background-color: whitesmoke;
}

#root {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100vh;
}
</style>
