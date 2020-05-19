const keys = require('./keys');
const redis = require('redis');

const redisClient = redis.createClient({
  host: keys.redisHost,
  port: keys.redisPort,
  retry_strategy: () => 1000
});

const sub = redisClient.duplicate();
console.log(keys)
function fib(index) {
    console.log(index)
  if (index < 2) return 1;
  return fib(index - 1) + fib(index - 2);
}

sub.on('message', (channel, message) => {
    console.log("ENTERED");
    
  redisClient.hset('values', message, fib(parseInt(message)));
});
sub.subscribe('insert');
