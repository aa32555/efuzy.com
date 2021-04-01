export function setList (ctx, val) {
  ctx.commit('setList', val)
}
export function refreshList (ctx, val) {
  const type = val.type
  ctx.commit('refreshList', {
    type: type
  })
}
