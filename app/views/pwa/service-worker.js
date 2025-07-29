// Add a service worker for processing Web Push notifications:
//
// self.addEventListener("push", async (event) => {
//   const { title, options } = await event.data.json()
//   event.waitUntil(self.registration.showNotification(title, options))
// })
//
// self.addEventListener("notificationclick", function(event) {
//   event.notification.close()
//   event.waitUntil(
//     clientes.matchAll({ type: "window" }).then((clienteList) => {
//       for (let i = 0; i < clienteList.length; i++) {
//         let cliente = clienteList[i]
//         let clientePath = (new URL(cliente.url)).pathname
//
//         if (clientePath == event.notification.data.path && "focus" in cliente) {
//           return cliente.focus()
//         }
//       }
//
//       if (clientes.openWindow) {
//         return clientes.openWindow(event.notification.data.path)
//       }
//     })
//   )
// })
