const validateQueryParams = (req, res, next) => {
  const { results, hours } = req.query;
  
  // Validar parámetro results
  if (results !== undefined) {
    const resultsNum = parseInt(results);
    if (isNaN(resultsNum) || resultsNum < 1 || resultsNum > 8000) {
      return res.status(400).json({
        success: false,
        message: 'El parámetro results debe ser un número entre 1 y 8000',
      });
    }
  }
  
  // Validar parámetro hours
  if (hours !== undefined) {
    const hoursNum = parseInt(hours);
    if (isNaN(hoursNum) || hoursNum < 1 || hoursNum > 168) {
      return res.status(400).json({
        success: false,
        message: 'El parámetro hours debe ser un número entre 1 y 168 (7 días)',
      });
    }
  }
  
  next();
};

module.exports = { validateQueryParams };
