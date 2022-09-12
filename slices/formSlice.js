
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
    storeSelect1: (state, action) => {
      state.value1 = action.payload
      
      if (action.payload == "1"){
        state.cost += 0.5
      }

      else if (state.cost > 0) {
        state.cost -= 0.5
      }

    },
    storeSelect2: (state, action) => {
      state.value2 = action.payload

      if (action.payload == "1"){
        state.cost += 1
      }

      else {
        state.cost += 1.5
      }

    },
    storeSelect3: (state, action) => {
      state.value3 = action.payload

      if (action.payload == "1"){
        state.cost += 0.5
      }

      else {
        state.cost -= 0.5
      }

    },
  },
})

// Action creators are generated for each case reducer function
export const { storeSelect1, storeSelect2, storeSelect3 } = formSlice.actions

export default formSlice.reducer