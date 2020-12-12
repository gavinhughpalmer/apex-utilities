/**
 * @author Gavin Palmer
 * @description A simple stack implementation to allow FILO on data structures
 *
 * @date 2020-11-20
 **/
public class Stack {
    private final List<Object> items = new List<Object>();

    public void push(Object item) {
        items.add(item);
    }

    public Object pop() {
        if (isEmpty()) {
            throw new UnderflowException();
        }
        return items.remove(items.size() - 1);
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

    public class UnderflowException extends Exception {
    }
}
