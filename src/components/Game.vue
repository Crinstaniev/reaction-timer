<template>
  <div class="container">
    <div id="submitting" v-if="isSubmitting">
      <p id="submit-text">Submitting...</p>
    </div>
    <div id="count-down" v-if="countDown">
      <p id="counter">{{ countDown }}</p>
    </div>
    <div id="description" v-if="showDesc">
      <p>
        Touch the screen<br />
        when it turns green!
      </p>
    </div>
    <div id="result" v-if="showResult">
      <p>
        Your reaction time is: <br />
        <span style="color: brown">{{ result }}</span> ms!
      </p>
      <p style="font-size: 0.5em">
        Share your result! <br />
        Enter your name: <input type="text" v-model="name" />
        <br />
        <button @click="handleSubmit">Submit</button>
        <button @click="handleCancel">Cancel</button>
      </p>
    </div>
  </div>
  <div id="green-screen" v-if="showGreenScreen" @click="handleTouch"></div>
</template>

<script>
import { service } from "../agent";

export default {
  emits: ["exit"],
  data() {
    return {
      countDown: 3,
      showDesc: false,
      timer: 0,
      randTimer: 0,
      showGreenScreen: false,
      timeCounter: null,
      randRecord: 0,
      result: 0,
      showResult: false,
      name: "",
      isSubmitting: false,
    };
  },

  mounted() {
    this.resetCounter();
  },

  methods: {
    resetCounter() {
      this.countDown = 3;
      this.showDesc = false;
      let counter = setInterval(() => {
        if (this.countDown > 0) {
          this.countDown -= 1;
        }
        if (this.countDown === 0) {
          this.showDesc = true;
          this.triggerTimer();
          window.clearInterval(counter);
        }
      }, 1000);
    },

    triggerTimer() {
      this.randRecord = Math.floor(Math.random() * 5000 + 1000);
      this.randTimer = this.randRecord;
      this.timeCounter = setInterval(() => {
        this.timer += 3;
        this.randTimer -= 3;
        if (this.randTimer <= 0) {
          this.showGreenScreen = true;
        }
      }, 3);
    },

    handleTouch() {
      this.result = this.timer - this.randRecord;
      this.showDesc = false;
      this.showGreenScreen = false;
      this.countDown = false;
      clearInterval(this.timeCounter);
      this.showResult = true;
    },

    async handleSubmit() {
      const payload = {
        name: this.name.trim(),
        record: this.result,
      };

      if (payload.name === "") {
        alert("Please enter your name!");
        return;
      }
      // first query whether the record exist
      let queryResult = await service.find(payload.name);
      // console.log(queryResult);

      if (queryResult.length !== 0) {
        const origin = Number(queryResult[0]);
        if (payload.record >= origin) {
          payload.record = origin;
        }
        if (
          !confirm(
            "The name exists in ranking.\n Do you want to update the record if you get a better score?",
          )
        ) {
          return;
        }
      }

      this.isSubmitting = true;
      await service.insert(payload.name, BigInt(payload.record));
      this.isSubmitting = false;
      this.$emit("exit");
    },

    handleCancel() {
      this.$emit("exit");
    },
  },
};
</script>

<style scoped>
@import url("../common/css/style.css");

#counter {
  font-size: 8em;
  user-select: none;
}

#description {
  font-size: 3em;
  user-select: none;
}

#result {
  font-size: 3em;
  user-select: none;
}

#green-screen {
  position: fixed;
  width: 100%;
  height: 100vh;
  background-color: green;
  z-index: 10;
}

button {
  margin: 10px;
}

#submitting {
  position: fixed;
  width: 100%;
  height: 100vh;
  z-index: 1000;
  background-color: whitesmoke;
  display: flex;
  justify-content: center;
  align-items: center;
}

#submit-text {
  font-size: 2em;
  font-weight: bold;
}
</style>