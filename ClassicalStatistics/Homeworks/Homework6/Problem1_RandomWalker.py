import random
import turtle


class Walker:
    """a random walker on a virtual lattice
    defines the rules of taking a step in a direction
    records the sequence of directions of the steps takem
    """

    # four directions
    DIRECTIONS = ('N', 'S', 'E', 'W')
    ID = 1

    def __init__(self):
        self.name = f"{self.__class__.__name__} no.: {Walker.ID}"
        Walker.ID += 1
        self.sequence_of_steps = []   # a sequence of directions

    def take_step(self):
        direction = random.choice(Walker.DIRECTIONS)
        self.sequence_of_steps.append(direction)

    def __str__(self):
        return f"{self.name}"


class RandomWalk:
    """manages Walkers take_step"""

    def __init__(self, walker=Walker, numwalkers=1, numsteps=100):
        self.numsteps = numsteps
        self.numwalkers = numwalkers
        self.walkers = [walker() for _ in range(numwalkers)]
        print(f'walking {self.numwalkers} {walker} for {self.numsteps} steps')
        self.do_walk()

    def do_walk(self):
        for step in range(self.numsteps):
            for walker in self.walkers:
                walker.take_step()

    def __str__(self):
        return '\n'.join(str(walker.sequence_of_steps)
                         for walker in self.walkers)


def paint_walker_path(walker):
    """paints the path of one walker on the canvas"""
    headings = {'N': 90, 'S': 270, 'E': 0, 'W': 180}
    unit_move = 10   # pixels

    direction_path = walker.sequence_of_steps
    t = turtle.Turtle()
    t.speed('fastest')
    t.color('green')
    t.dot(size=10)

    t = turtle.Turtle()
    t.color('gray')
    report = turtle.Turtle()
    report.penup()
    report.hideturtle()
    report.goto(200, 200)
    report.write("step: ", True, font=('courier', 18, 'normal'))
    report.write('0', font=('courier', 18, 'normal'))
    for idx, direction in enumerate(direction_path):
        t.setheading(headings[direction])
        t.forward(unit_move)
        t.dot(size=4)
        report.undo()
        report.penup()
        report.pendown()
        report.write(f"{idx}", font=('courier', 18, 'normal'))
    t.hideturtle()
    t.color('red')
    t.dot(6)
    t.goto(0, 0)


def paint_path(direction_path):
    headings = {'N': 90, 'S': 270, 'E': 0, 'W': 180}
    unit_move = 10  # pixels

    t = turtle.Turtle()
    t.speed('fastest')
    t.color('black')

    t = turtle.Turtle()
    t.color('black')
    t.pensize(2)
    for direction in direction_path:
        t.setheading(headings[direction])
        t.forward(unit_move)
        t.dot(size=4)
    t.hideturtle()


class Coordinate:

    # offsets are (col, row) i/e (x, y)
    OFFSETS = {'N': (0, 1), 'S': (0, -1), 'E': (1, 0), 'W': (-1, 0)}
    COORD_TO_DIR = {(0, 1): 'N', (0, -1): 'S', (1, 0): 'E', (-1, 0): 'W'}

    def __init__(self, col, row):
        self.col = col
        self.row = row
        self.coord = (self.col, self.row)

    def get_adjacent(self, direction):
        """returns a new Coordinate object adjacent to self
         in the given direction
        """
        d_col, d_row = Coordinate.OFFSETS[direction]
        return Coordinate(self.col + d_col, self.row + d_row)

    def get_direction(self, destination):
        """returns the direction to take in order to move
        from self to destination"""
        offcol = destination.col - self.col
        offrow = destination.row - self.row
        assert abs(offcol) <= 1 and abs(offrow) <= 1, "adjacent coordinates must be close by"
        return Coordinate.COORD_TO_DIR[(offcol, offrow)]

    def __hash__(self):
        return hash(self.coord)

    def __eq__(self, other):
        return self.coord == other.coord

    def __str__(self):
        return f"Coordinate {self.coord}"

    def __repr__(self):
        return str(self)


ORIGIN = Coordinate(0, 0)


class Lattice:
    def __init__(self):
        self.adjacency = {}

    def get_final_dest_and_merge_sequence_of_steps(self, sequence_of_steps,
                                                   origin=ORIGIN):
        current_coordinate = origin
        for direction in sequence_of_steps:
            adjacent_coordinate = current_coordinate.get_adjacent(direction)
            try:
                self.adjacency[current_coordinate].add(adjacent_coordinate)
            except KeyError:
                self.adjacency[current_coordinate] = {adjacent_coordinate}
            try:
                self.adjacency[adjacent_coordinate].add(current_coordinate)
            except KeyError:
                self.adjacency[adjacent_coordinate] = {current_coordinate}
            current_coordinate = adjacent_coordinate
        return current_coordinate

    @staticmethod
    def extract_sequence_of_steps(seq_of_coordinates):
        steps = []
        current_coord = seq_of_coordinates[0]
        for next_destination in seq_of_coordinates[1:]:
            steps.append(current_coord.get_direction(next_destination))
            current_coord = next_destination
        return steps

    def __str__(self):
        adjacency = []
        for k, v in self.adjacency.items():
            adjacency.append(f'{k},: {v}\n')
        return ''.join(adjacency)


class BFS:

    def __init__(self, lattice, start_coord, end_coord):
        self.lattice = lattice
        self.start_coord = start_coord
        self.end_coord = end_coord
        self.shortest_path = None   # a sequence of Coordinate
        self.bfs()

    def bfs(self):
        queue = []
        visited = set()
        queue.append([self.start_coord])
        while queue:
            path = queue.pop(0)
            print("queue: ", queue, "path: ", path)
            node = path[-1]
            if node == self.end_coord:
                self.shortest_path = path
                break
            if node not in visited:
                for adjacent in self.lattice.adjacency.get(node, []):
                    new_path = list(path)
                    new_path.append(adjacent)
                    queue.append(new_path)
            visited.add(node)


if __name__ == '__main__':

    walk = RandomWalk(walker=Walker, numsteps=50)
    print(walk)

    Levon = walk.walkers[0]

    paint_walker_path(Levon)
    print("Done by Levon")

    lattice = Lattice()
    end_node = lattice.get_final_dest_and_merge_sequence_of_steps(Levon.sequence_of_steps)
    print(end_node)
    print(lattice)

    search = BFS(lattice, ORIGIN, end_node)
    print('search: ', search.shortest_path)

    shortest_Levon = Lattice.extract_sequence_of_steps(search.shortest_path)
    paint_path(shortest_Levon)

    turtle.done()
