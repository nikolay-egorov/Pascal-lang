using System;

namespace JetBrains.ReSharper.Plugins.Spring.exept {
    public class AnalysisException : Exception {
        public AnalysisException() {
        }

        public AnalysisException(string message) : base(message) {
        }

        public AnalysisException(string message, Exception innerException) : base(message, innerException) {
        }
    }
}