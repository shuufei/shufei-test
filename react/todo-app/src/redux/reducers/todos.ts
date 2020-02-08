import { addTodo, AddTodoAction, toggleTodo, ToggleTodoAction } from '../actionTypes';

type Actions = AddTodoAction | ToggleTodoAction;

export type Todo = {
  id: number;
  text: string;
  completed: boolean;
}

export type State = {
  todos: Todo[];
};

const init = (): State => {
  return {
    todos: [],
  };
};

export const reducer = (state: State = init(), action: Actions) => {
  switch (action.type) {
    case 'ADD_TODO':
      return {
        todos: [
          ...state.todos,
          {
            id: state.todos.length,
            text: action.payload.text,
            complated: false,
          }
        ]
      };
    case 'TOGGLE_TODO':
      return {
        todos: state.todos.map(v => {
          return v.id !== action.payload.id
            ? v
            : {
              ...v,
              completed: !v.completed
            };
        })
      };
    default:
      return state;
  }
}

export const actionCreator = {
  addTodo,
  toggleTodo
};
