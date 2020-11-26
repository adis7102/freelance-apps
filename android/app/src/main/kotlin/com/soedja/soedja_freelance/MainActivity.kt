package com.soedja.soedja_freelance


import android.annotation.SuppressLint
import android.widget.Toast
import com.midtrans.sdk.corekit.callback.TransactionFinishedCallback
import com.midtrans.sdk.corekit.core.MidtransSDK
import com.midtrans.sdk.corekit.core.PaymentMethod
import com.midtrans.sdk.corekit.core.TransactionRequest
import com.midtrans.sdk.corekit.core.themes.CustomColorTheme
import com.midtrans.sdk.corekit.models.CustomerDetails
import com.midtrans.sdk.corekit.models.ItemDetails
import com.midtrans.sdk.corekit.models.snap.TransactionResult
import com.midtrans.sdk.uikit.SdkUIFlowBuilder
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity(), TransactionFinishedCallback {

    private val CHANNEL = "com.soedja.soedja_freelance"
    private val KEY_NATIVE = "showPayment"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->

            if (call.method == KEY_NATIVE) {

                val email = ("" + call.argument("email"))
                val phone = ("" + call.argument("phone"))
                val fullName = ("" + call.argument("full_name"))

                val paymentId = ("" + call.argument("payment_id"))
                val price = ("" + call.argument("price")).toDouble()
                val name = ("" + call.argument("name"))
                val qty = ("" + call.argument("quantity")).toInt()

                initMidtransSDK()

                val setting = MidtransSDK.getInstance().uiKitCustomSetting
                setting.setSkipCustomerDetailsPages(true)
                MidtransSDK.getInstance().uiKitCustomSetting = setting

                val request = TransactionRequest(paymentId, price * qty)

                val customerDetails = setCustomer(email, phone, fullName, fullName)
                request.setCustomerDetails(customerDetails)

                val itemDetails = ArrayList<ItemDetails>()
//                itemDetails.add(ItemDetails(paymentId,name, price, qty))
                itemDetails.add(ItemDetails(paymentId, price, qty, name))
                request.setItemDetails(itemDetails)

                MidtransSDK.getInstance().setTransactionRequest(request)

                MidtransSDK.getInstance().startPaymentUiFlow(this)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun initMidtransSDK() {
        SdkUIFlowBuilder.init()
                .setContext(this)
                .setMerchantBaseUrl(BuildConfig.BASE_URL)
                .setClientKey(BuildConfig.CLIENT_KEY)
                .setTransactionFinishedCallback(this)
                .enableLog(true)
                .setColorTheme(CustomColorTheme("#FFE51255", "#B61548", "#FFE51255"))
                .buildSDK()
    }

    private fun setCustomer(email: String?, phone: String?, firstName: String?, lastName: String?): CustomerDetails {
        val customer = CustomerDetails()
        customer.email = email
        customer.phone = phone
        customer.firstName = firstName
        customer.lastName = lastName

        return customer
    }

    @SuppressLint("ShowToast")
    override fun onTransactionFinished(result: TransactionResult) {
        if (result.response != null) {
            when (result.status) {
                TransactionResult.STATUS_SUCCESS -> Toast.makeText(context, "Success ID: " + result.response.transactionId, Toast.LENGTH_SHORT)
                TransactionResult.STATUS_PENDING -> Toast.makeText(context, "Pending ID: " + result.response.transactionId, Toast.LENGTH_SHORT)
                TransactionResult.STATUS_FAILED -> Toast.makeText(context, "Failed ID: " + result.response.transactionId, Toast.LENGTH_SHORT)
            }
        } else if (result.isTransactionCanceled) {
            Toast.makeText(context, "Cancel ID: " + result.response.transactionId, Toast.LENGTH_SHORT)
        } else {
            if (result.status.equals(TransactionResult.STATUS_INVALID, ignoreCase = true)) {
                Toast.makeText(context, "Invalid ID: " + result.response.transactionId, Toast.LENGTH_SHORT)
            } else {
                Toast.makeText(context, "Finished with failure ID: " + result.response.transactionId, Toast.LENGTH_SHORT)
            }
        }
    }

}