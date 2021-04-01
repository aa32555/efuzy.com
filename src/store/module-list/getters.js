export function list (state) {
  return function (type) { return state.list[type] }
}

export function refresh (state) {
  return function (type) { return state.refresh[type] }
}
