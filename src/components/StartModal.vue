<template>
  <!-- Start Game, Global Rank -->
  <div class="container">
    <div class="header">Reaction Timer</div>
    <div class="modal-container">
      <div class="grid" @click="handleRankingClick"><p>Global Ranking</p></div>
      <div class="grid" @click="handleStartClick"><p>Game Start</p></div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {};
  },

  methods: {
    async handleRankingClick() {
      this.$emit("to-rank");
    },

    async handleStartClick() {
      this.$emit("to-start");
    },
  },
};
</script>

<style>
.modal-container {
  width: 400px;
  height: 300px;
  background-color: #005587;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 10%;
  flex-direction: column;
  box-shadow: 2px 2px 5px grey;
  margin-bottom: 150px;
}

.header {
  font-size: 35px;
  margin: 15px;
  font-weight: bold;
}

.grid {
  height: 75px;
  width: 75%;
  background-color: white;
  margin: 20px;
  border-radius: 20px;
  background-color: whitesmoke;
  display: inherit;
  align-items: center;
  justify-content: center;
  font-size: 1.5em;
  font-weight: bold;
  user-select: none;
}

.grid:hover {
  background-color: #e2e6ed;
}

.grid:active {
  background-color: #dad0c6;
}
</style>