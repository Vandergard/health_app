const { environment } = require("@rails/webpacker");

// Добавьте эту строку, если у вас возникают проблемы с импортом и экспортом модулей
environment.loaders.delete("nodeModules");

module.exports = environment;