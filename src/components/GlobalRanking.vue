<template>
  <div class="container">
    <div id="header">
      <p>Global Ranking</p>
    </div>
    <div id="rank-container">
      <div class="body" id="records">
        <div class="record-item" v-for="item in records" :key="item.name">
          <div class="item-text">{{ item.rankCnt }} - {{ item.name }}</div>
          <div class="item-text">{{ item.score }} ms</div>
        </div>
      </div>
      <div class="footer container" @click="handleExit">
        <p class="text">Exit</p>
      </div>
    </div>
  </div>
</template>

<script>
import { service } from "../agent";

export default {
  data() {
    return {
      records: [],
    };
  },

  methods: {
    handleExit() {
      this.$emit("exit");
    },
  },

  async mounted() {
    const result = await service.getAll();
    let recordsPayload = [];
    result.map((item) => {
      const payload = {
        name: item[0],
        score: Number(item[1]),
      };
      recordsPayload.push(payload);
    });
    recordsPayload.sort((a, b) => a.score - b.score);
    let rankCnt = 0;
    recordsPayload.map((item) => {
      rankCnt += 1;
      this.records.push({
        ...item,
        rankCnt,
      });
    });
    // console.log(this.records);
  },
};
</script>

<style scoped>
@import url("../common/css/style.css");

#rank-container {
  width: 50%;
  height: 70%;
  background-color: #ccc;
  overflow: scroll;
  border-radius: 20px;
  justify-content: center;
  display: flex;
  align-items: center;
  flex-direction: column;
  padding: 15px;
}

#header {
  font-size: 2em;
  font-weight: bold;
}

.body {
  width: 100%;
  height: 100%;
  border-radius: 20px;
  background-color: whitesmoke;
  display: flex;
  align-items: center;
}

.footer {
  width: 50%;
  height: 7%;
  margin-top: 5%;
  border-radius: 10px;
  background-color: black;
  color: whitesmoke;
}

.text {
  font-size: 1.5em;
  font-weight: bold;
  color: inherit;
}

.footer:hover {
  color: lightgrey;
}

.footer:active {
  color: grey;
}

#records {
  padding-top: 10px;
  padding-bottom: 10px;
  display: flex;
  flex-direction: column;
  width: 100%;
  overflow: scroll;
}

.record-item {
  width: 80%;
  height: 50px;
  background-color: black;
  margin-top: 5px;
  margin-bottom: 5px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-left: 15px;
  padding-right: 15px;
}

.item-text {
  font-size: 1.5em;
  color: white;
  font-weight: bold;
}
</style>