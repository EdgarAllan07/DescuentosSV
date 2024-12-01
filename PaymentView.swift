import SwiftUI
import PassKit

struct PaymentView: View {
    let total: Double  // Este es el total que pasas desde el carrito

    var body: some View {
        VStack {
            Text("Pago con Apple Pay (Simulado)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            // Mostrar el total calculado desde el carrito
            Text(String(format: "Total a Pagar: $%.2f", total))
                .font(.title2)
                .padding(.top)

            if PKPaymentAuthorizationController.canMakePayments() {
                ApplePayButtonView(total: total)  // Pasamos el total aquí
                    .frame(height: 50)  // Ajusta la altura del botón
                    .padding()
            } else {
                Text("Apple Pay no está disponible en este dispositivo.")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }
}

struct ApplePayButtonView: UIViewRepresentable {
    let total: Double  // Recibimos el total desde PaymentView

    func makeUIView(context: Context) -> PKPaymentButton {
        let paymentButton = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
        return paymentButton
    }
    
    func updateUIView(_ uiView: PKPaymentButton, context: Context) {
        uiView.addTarget(context.coordinator, action: #selector(Coordinator.initiatePayment), for: .touchUpInside)
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(total: total)  // Pasamos el total al Coordinator
    }

    class Coordinator: NSObject {
        let total: Double  // Guardamos el total

        init(total: Double) {
            self.total = total
        }

        @objc func initiatePayment() {
            let paymentRequest = PKPaymentRequest()

            // Configuración del simulador de pago
            paymentRequest.merchantCapabilities = .capability3DS // Capacidad de autenticación 3D Secure
            paymentRequest.countryCode = "US"                   // Código de país
            paymentRequest.currencyCode = "USD"                 // Moneda
            paymentRequest.supportedNetworks = [.visa, .masterCard, .amex]
            paymentRequest.merchantIdentifier = "merchant.simulated.identifier" // Simulado
            
            // Usamos el total que se pasa a esta vista
            paymentRequest.paymentSummaryItems = [
                PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(value: total))
            ]

            // Presentar el controlador de pago
            let paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
            paymentController.delegate = ApplePayDelegate()
            paymentController.present { success in
                if success {
                    print("Se presentó el flujo de Apple Pay.")
                } else {
                    print("Falló la presentación del flujo de Apple Pay.")
                }
            }
        }
    }
}

class ApplePayDelegate: NSObject, PKPaymentAuthorizationControllerDelegate {
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        // Cierra el flujo de Apple Pay
        DispatchQueue.main.async {
            controller.dismiss {
                print("El flujo de Apple Pay se cerró.")
            }
        }
    }

    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        // Simulación de autorización de pago
        print("Pago autorizado: \(payment)")
        // Se devuelve el resultado de autorización con éxito
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }

    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didFailWithError error: Error) {
        // Manejo de error si ocurre algo inesperado durante el proceso
        print("Error durante la autorización del pago: \(error.localizedDescription)")
        DispatchQueue.main.async {
            controller.dismiss {
                print("El flujo de Apple Pay se cerró debido a un error.")
            }
        }
    }
}
