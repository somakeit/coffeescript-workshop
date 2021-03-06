Controller = require('../controller');

FibonacciController = () ->
  # Call parent's constructor
  Controller.apply(this, arguments);
  return this;


# Inherit from Controller
(() ->
  noop = () ->
  noop.prototype = Controller.prototype;
  FibonacciController.prototype = new noop()
)();

# Copy over middleware, etc
for k of Controller
  if (Controller.hasOwnProperty(k))
    FibonacciController[k] = Controller[k];



FibonacciController.prototype.calculateNthFibonacci = (n) ->
  if (n <= 0)
    return 0;

  if (n is 1)
    return 1;

  return this.calculateNthFibonacci(n - 2) + this.calculateNthFibonacci(n - 1);


FibonacciController.prototype.dispatch = () ->
  this.number = parseInt(this.req.params.arg, 10);
  if (!isFinite(this.number))
    this.number = Math.ceil(Math.random() * 20);

  if (this.number < 1)
    this.number = 1;

  this.res.send("" + this.number + "th Fibonacci number is: " + this.calculateNthFibonacci(this.number));


module.exports = FibonacciController;
