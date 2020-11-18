public class Stack {
    private final List<Object> items = new List<Object>();

    public void push(String item) {
        items.add(item);
    }

    public void pop() {
        if (isEmpty()) {
            throw new UnderflowException();
        }
        items.remove(items.size() - 1);
    }

    public Integer size() {
        return items.size();
    }

    public Boolean isEmpty() {
        return items.isEmpty();
    }

    public override String toString() {
        return String.join(items, '\n');
    }

    public class UnderflowException extends Exception {}
}