package performanceRunners

import com.intuit.karate.gatling.PreDef.{karateFeature, karateProtocol}
import io.gatling.core.Predef.{Simulation, openInjectionProfileFactory, rampUsers, scenario}

import scala.concurrent.duration.{Duration, SECONDS}

class UserSimulation extends Simulation{

  val myFirstLoadTest = scenario("load test").exec(karateFeature("classpath:feature/Demo1.feature"))

  val protocol = {
    karateProtocol()
  }

  setUp(
    myFirstLoadTest.inject(rampUsers(5) during(Duration(5, SECONDS))).protocols(protocol)

  )
}