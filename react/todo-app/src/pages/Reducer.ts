import { Reducer } from 'react';
import { Todo } from '../redux/reducers/todos';

const mock: Todo[] = [
  { id: 0, text: 'task00', completed: false },
  { id: 1, text: 'task01', completed: true },
  { id: 2, text: 'task02', completed: false },
];

export type State = {todos: Todo[]};
export type Action =
  { type: 'add', payload: Todo['text'] }
  | { type: 'done', payload: Todo['id'] }
  | { type: 'undone', payload: Todo['id'] }

export const initialState: State = { todos: mock };

export const reducer: Reducer<State, Action> = function(state, action) {
  let targetIndex: number;
  let todo: Todo[] = [];
  switch (action.type) {
    case 'add':
      return { todos: [...state.todos, { id: state.todos.length, text: action.payload, completed: false }] }
    case 'done':
      targetIndex = state.todos.findIndex(v => v.id === action.payload);
      if (targetIndex === -1) { return state; }
      todo = state.todos.splice(targetIndex, 1);
      todo[0].completed = true;
      return { todos: [...state.todos, ...todo] };
    case 'undone':
      targetIndex = state.todos.findIndex(v => v.id === action.payload);
      if (targetIndex === -1) { return state; }
      todo = state.todos.splice(targetIndex, 1);
      todo[0].completed = false;
      return { todos: [...state.todos, ...todo] };
    default:
      throw new Error();
  }
}