---
categories: ["development", "algo", "aoc"]
title: "Advent Of Code 2015, Day 1"
date: 2020-11-29T15:43:42+01:00
tags: ["aoc", "aoc2015"]
math: true
---

Let's begin, shall we? This is the problem that started the whole AoC, So what better place to start this? I won't give
a complete course of CompSci, probably I'm not qualified for that. And AoC is far too simple to be a good candidate for
this. So I'll be verbose, knowing full well that skilled people will skim that, trying to be at the same time useful for
people approaching writing code.

# The problem

The [problem](https://adventofcode.com/2015/day/1) is fairly simple:

_Santa is trying to deliver presents in a large apartment building, but he can't find the right floor - the directions
he got are a little confusing. He starts on the ground floor (floor 0) and then follows the instructions one character
at a time._

So here we have the starting point defined. Our problem start from `0` and goes up or down.

_An opening parenthesis, (, means he should go up one floor, and a closing parenthesis, ), means he should go down one
floor._

This is also very straightforward, and it's a little transformation: when whe a `(` is found, we do a `+1 floor`; when
we `)` is found we do `-1 floor` instead. We still don't know in what format will be the input, nor the output. So we
are keeping the abstraction for now.

_The apartment building is very tall, and the basement is very deep; he will never find the top or bottom floors._

So we go from $-\inf$ to $+\inf$ and we start from a middle point. Cool.

I will start using ruby as is easy to read and I'm fairly confident with it. But I will also try to provide solutions in multiple languages, and using multiple techniques. My goal is to learn _and_ teach.

# The Working implementation

At the time of writing, the ruby version I'm using is `ruby 2.7.0p0 (2019-12-25 revision 647ee6f091) [x86_64-linux]`. It's reasonably fast, but we are not chasing $\mu$-seconds, so I want bother much for now. For starter, let's create a simple skeleton that gets the input file from a folder and that I can actually reuse in the future.

The folder tree looks like this:

```sh
.
├── inputs
│   └── day1.input
└── ruby
    └── day1.rb
```

So, this is what I came up with:

```ruby
fname = File.basename(__FILE__, '.rb')
input = File.read(File.expand_path("../inputs/#{fname}.input", __dir__))
```

This will read complete input in a variable named `input`. Neat, eh? Don't worry if you don't understand it at the
moment, I promise you will. If there is someone reading this, of course. We can now process the input, knowing that we
**(1)** start from zero and **(2)** we consume one character at the time.

The most naive solution that comes to mind is reading each character and incrementing/decrementing a counter, so let's
write that!

```ruby
count = 0

input.each_char do |c|
  if c == '(' then
    count += 1
  elsif c == ')' then
    count -= 1
  end
end

puts count
```

This prints **280** in the console and, when we input this on the AoC website... one freakin gold star! But this
solution is kinda horrible. We can do much better, and we will. Still, this is a _working_ solution and we don't have to
discount that. At the end of the day AoC is a competition, and writing speed is key. We are not competing of course, but
more often than not developers overthink their solution, when _quick 'n dirty_ will do.

Let's get on with the second part.

_Now, given the same instructions, find the position of the first character that causes him to enter the basement (floor
-1). The first character in the instructions has position 1, the second character has position 2, and so on._

Here we have a stopping condition. As soon as we hit the `-1` floor we have to communicate the character position. In
the example provided we see that it does start from `1` and not `0` like every array in most of the programming language
(the only one that comes to mind is _Lua_), so we have to keep in mind that. It's _really_ important to understand the
problem before trying to solve it in my opinion, that's why I'm stressing on the comprehension.

The simplest code I can write is based of the first part of the problem.

```ruby
count = 0
minus_one_index = -1

input.each_char.with_index do |c, idx|
  if c == '('
    count += 1
  elsif c == ')'
    count -= 1
  end

  if count == -1 && minus_one_index == -1
    minus_one_index = idx+1
  end
end

puts count, minus_one_index
```

This way we cycle only once through the string, and we keep track when we find for the first time a value of `-1` as
result of the computation. Nice!

```sh
❯ ruby day1.rb
280
1797
```

And when we input this... Second gold star! The next chapters will be optional, so if you are only intersted in a
working solution/approach, that's your stop. :)

# Optimizations & Other Languages

We can make the code more _ruby-like_ if we want, and that's exactly what we are going to do. For example the [Ruby
style-guide](https://rubystyle.guide/), enforced by [Rubocop](https://rubocop.org/), give us this suggestion:

```sh
day1.rb:8:3: C: Style/CaseLikeIf: Convert if-elsif to case-when.
  if c == '(' ...
  ^^^^^^^^^^^
```

Uhm, ok. Let's try that. The `if-elsif` became:

```ruby
case c
when '('
  count += 1
when ')'
  count -= 1
end
```

While this is clear, the only difference is that is less verbose and communicate the intent _slightly_ better. My
opinion on the matter is that our original implementation is more clear for someone new in the world of programming
languages, because it "reads" better in english. Not a strong point, but that's just an opinion, right?

At this point nothing is stopping us to avoid a repetition and get `count` outside of the `case`, like this:

```ruby
count += case c
         when '(' then 1
         when ')' then -1
         else 0
         end
```

In Ruby `case-when` (also `if-else`) is an expression, and an expression evaluate to something. So the inside of the
branches become our return value.

Another thing that's important is to froze the strings. In this example is not very important by the way, because we
have only one string and we use it one time only. But by freezing strings we are saving memory and making string
immutable by default. This is a good habit to catch one, given also that `Ruby 3` (coming this christmas), will have
frozen string _by default_. The concept of immutability is far from complex. We create an object and, as long as it
lives it can be only read. "But how can we modify the string this way?". We can't, and we shouldn't. This makes our code
safer for the most part, raising an issue when we try to modify a string. Safe**r**, not _safe_, to avoid
misunderstandings. If we need a transformation of the string, we need to create a new string. [This stackoverflow
answer](https://stackoverflow.com/a/55900180) show the impact of this comment in a very coincise way, so I won't
reinvent the wheel.

So we just add `# frozen_string_literal: true` at the top of the file. Done.

See you next time.
