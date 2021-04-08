import numpy as np
import cv2


class Shape:

    def draw(self, screen, thickness=None):
        pass

    @staticmethod
    def _relative_to_pixel(screen, point):
        return int(screen.shape[1] * point[0]), int(screen.shape[1] * point[1])


class Rect(Shape):

    def __init__(self, pt1, pt2, color):
        self.pt1 = pt1
        self.pt2 = pt2
        self.color = color

    def draw(self, screen, thickness=None):
        pt1 = super()._relative_to_pixel(screen, self.pt1)
        pt2 = super()._relative_to_pixel(screen, self.pt2)
        cv2.rectangle(screen, pt1, pt2, self.color, thickness=thickness)


class Circ(Shape):

    def __init__(self, center, radius, color):
        self.center = center
        self.radius = radius
        self.color = color

    def draw(self, screen, thickness=None):
        center = super()._relative_to_pixel(screen, self.center)
        radius = int(screen.shape[1] * self.radius)
        cv2.circle(screen, center, radius, self.color, thickness=thickness)


class Drawer:

    def __init__(self, width: int, height: int):
        self.screen = np.zeros((height, width, 3), np.uint8)
        self.shapes = None

    def show(self, callback=None):
        try:
            while True:
                if callback is not None:
                    callback()

                # Clear screen to black
                self.screen.fill(0)
                # Draw shapes
                if self.shapes is not None:
                    for shape in self.shapes:
                        shape.draw(self.screen, thickness=-1)
                # Create a full screen window
                cv2.namedWindow('doldamgil', cv2.WND_PROP_FULLSCREEN)
                cv2.setWindowProperty('doldamgil', cv2.WND_PROP_FULLSCREEN, cv2.WINDOW_FULLSCREEN)
                cv2.imshow('doldamgil', self.screen)

                # Wait for keyboard input
                keycode = cv2.waitKey(1000)
                if keycode != -1 and keycode != 255:
                    break
        except KeyboardInterrupt:
            pass

    def close(self):
        cv2.destroyWindow('doldamgil')


if __name__ == '__main__':
    drawer = Drawer(1920, 1080)
    drawer.shapes = [
        Rect((0.80, 0.40), (0.85, 0.45), (255, 0, 0)),
        Rect((0.70, 0.30), (0.75, 0.35), (0, 255, 0)),
        Rect((0.60, 0.25), (0.65, 0.30), (0, 255, 0)),
        Rect((0.50, 0.20), (0.55, 0.25), (0, 255, 0)),
        Rect((0.30, 0.15), (0.35, 0.20), (0, 255, 0)),
        Rect((0.20, 0.10), (0.25, 0.15), (0, 0, 255))
    ]
    drawer.show()
    drawer.shapes = [
        Circ((0.20, 0.40), 0.025, (255, 0, 0)),
        Circ((0.30, 0.30), 0.025, (0, 255, 0)),
        Circ((0.50, 0.25), 0.025, (0, 255, 0)),
        Circ((0.60, 0.20), 0.025, (0, 255, 0)),
        Circ((0.70, 0.15), 0.025, (0, 255, 0)),
        Circ((0.80, 0.10), 0.025, (0, 0, 255))
    ]
    drawer.show()
    drawer.close()
