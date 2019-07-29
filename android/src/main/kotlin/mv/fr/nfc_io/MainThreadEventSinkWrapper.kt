package mv.fr.nfc_io

import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.EventChannel

class MainThreadEventSinkWrapper internal constructor(private val eventSink: EventChannel.EventSink) : EventChannel.EventSink {
    private val handler: Handler

    init {
        handler = Handler(Looper.getMainLooper())
    }

    override fun endOfStream() {
        handler.post(Runnable { eventSink.endOfStream() })
    }

    override fun success(o: Any) {
        handler.post(Runnable { eventSink.success(o) })
    }

    override fun error(s: String, s1: String, o: Any) {
        handler.post(Runnable { eventSink.error(s, s1, o) })
    }
}