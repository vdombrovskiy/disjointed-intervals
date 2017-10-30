App for managing disjoint intervals

Requirements: ruby-2.4.0

Run specs: ruby spec_runner.rb
Run app: ruby runner.rb

Here is an example sequence:
1. Call: add(1, 5) => [[1, 5]]
2. Call: remove(2, 3) => [[1, 2], [3, 5]]
3. Call: add(6, 8) => [[1, 2], [3, 5], [6, 8]]
4. Call: remove(4, 7) => [[1, 2], [3, 4], [7, 8]]
5. Call: add(2, 7) => [[1, 8]]
