const errorHandler = (err, req, res, next) => {
  console.error('🚨 Error:', err);

  // Error de validación
  if (err.name === 'ValidationError') {
    return res.status(400).json({
      success: false,
      message: 'Error de validación',
      errors: err.details || err.message,
    });
  }

  // Error de ThingSpeak API
  if (err.message.includes('ThingSpeak')) {
    return res.status(503).json({
      success: false,
      message: 'Servicio meteorológico temporalmente no disponible',
      error: process.env.NODE_ENV === 'development' ? err.message : undefined,
    });
  }

  // Error de timeout
  if (err.code === 'ECONNABORTED' || err.message.includes('timeout')) {
    return res.status(504).json({
      success: false,
      message: 'Timeout del servicio meteorológico',
    });
  }

  // Error de conexión
  if (err.code === 'ECONNREFUSED' || err.code === 'ENOTFOUND') {
    return res.status(503).json({
      success: false,
      message: 'Servicio meteorológico no disponible',
    });
  }

  // Error genérico
  res.status(err.status || 500).json({
    success: false,
    message: err.message || 'Error interno del servidor',
    error: process.env.NODE_ENV === 'development' ? err.stack : undefined,
  });
};

module.exports = { errorHandler };
