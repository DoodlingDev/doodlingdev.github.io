---
layout: post
title: You can't test React Native like you test React Web
excerpt_separator: <!--more-->
---

When the DOM you're rendering into is the familiar DOM of the browser, there's a whole world of tooling and capability for mocking the environment.

With React Native? Not so much.

<!--more-->

We can use Enzyme, but we're pretty limited to shallow rendering. That gives a modicum of usefulness, but a large part of the testing we want requires mounting the component in a mock DOM. With AirBnB famously migrating away from React Native, I don't think there will be a lot of focus on making Enzyme more friendly to use for the mobile React world.

What I see most often for React Native test coverage is trying to do everything needed with snapshot testing. Trying to match snapshots with different state, maybe throwing in a different prop and seeing how that changes the markup.

Snapshot testing isn't intended to be used as full-fledged unit tests, that creates problems of its own...

### Small changes take disproportionate attention

If we change some text in an element, odds are we don't want that to cause a test failure. Updating a snapshot feels like it takes no time at all, but if we're testing behavior with multiple snapshots, likely that one insignificant change caused the whole component's suite to fail.

### Human verifiable means unreliable

It's not always clear what we should be looking for when updating snapshots. If it's something written by another dev, it's almost impossible to know if we should accept the diff.

The imperative plea to *"use descriptive titles when writing snapshots"* is direct fallout from this lack of clarity. Naming matters, but if we rely on a human being to correctly *interpret* the name of the test to decide whether it passed or failed... we've missed the point of automated testing.

### Snapshots test inconsequential markup

Test only the parts of your component that are absolutely vital. Is there supposed to be text and a continue button? Assert on the presence of these things that actually matter. Constant snapshot failures and large diffs in markup that don't impact a component's functionality are just noise.

### Interfaces go untested

Interfaces with other components, modules or libraries aren't going to show up in a snapshot. A test suite should warn us when components are getting out of sync with their messaging. Those are the kind of bugs don't always throw errors and cost too much time and effort to track down and fix.

All these reasons are why we might reach for something like enzyme in the first place, but without mounting in the environment of the browser (that enzyme was built for), it falls short.

### What tools can we use?

Part of the main React project is `react-test-renderer`. The part of React's testing suite that builds the serializable representation of our component tree. It's what we call `.toJSON()` on to match snapshots.

In my next post, I'll go through some examples of how to leverage React's built in testing tools to get the kind of functionality we need to properly test React Native applications.

