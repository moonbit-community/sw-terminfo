test "test parse xterm-256color" (t : @test.Test) {
  let xterm256color = @samples.xterm256colorBytes
  let terminal = @parser.Terminal::from_bytes(xterm256color)
  t.write(terminal)
  t.snapshot(filename="xterm-256color.parsed.txt")
}
