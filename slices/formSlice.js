
import { createSlice } from '@reduxjs/toolkit'

const initialState = {
  cost: 0,
  value1: 0,
  value2: 0,
  value3: 0,
}

export const formSlice = createSlice({
  name: 'form',
  initialState,
  reducers: {

    // Function to store state/value of the first input "Bubbles?" 
    storeSelect1: (state, action) => {
      state.value1 = parseInt(action.payload);

      if (action.payload == "1") {
        state.cost += 0.5
      }
      else {
        state.value1 -= 0.5
      }
    },

    // Function to store state/value of the second input "Do you want cream?"
    storeSelect2: (state, action) => {
      state.value2 = parseInt(action.payload);

      if (action.payload == "1") {
        state.cost += 0.5
      }
      else {
        state.cost -= 0
      }
    },

    // Function to store state/value of the third input "Tea or Latte?"
    storeSelect3: (state, action) => {
      state.value3 = parseInt(action.payload);
      // Disclaimer: This is probably a very bad way of doing things
      // This doesn't take into account the previous value
      // Hence, the total value will keep on incrementing
      if (action.payload == "1") {
        state.cost += 1
      }
      else {
        state.cost += 1.5
      }
    },
  },
})

// Action creators are generated for each case reducer function
export const { storeSelect1, storeSelect2, storeSelect3 } = formSlice.actions

export default formSlice.reducer