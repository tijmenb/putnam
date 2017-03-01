import unittest
import echo

class TestDeployEndpoint(unittest.TestCase):

    def test_returns_what_it_should(self):
        self.assertIsNotNone(echo.lambda_handler({}, {}))

if __name__ == '__main__':
    unittest.main()
