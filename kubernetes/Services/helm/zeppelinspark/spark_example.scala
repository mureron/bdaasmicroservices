sc.parallelize(List(1,2,3)).flatMap(x=>List(x,x,x)).collect



val count = sc.parallelize(1 to 10000).filter { _ =>
  val x = math.random
  val y = math.random
  x*x + y*y < 1
}.count()
println(s"Pi is roughly ${4.0 * count / 10000}")


%pyspark
sc.parallelize(range(1,10)).collect()