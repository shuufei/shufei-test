import { Reducer } from 'react';
import { Todo } from './components/TodoItem';

const mock: Todo[] = [
  { id: '0', title: 'task00', isDone: false },
  { id: '1', title: 'task01', isDone: true },
  { id: '2', title: 'task02', isDone: false },
];

export type State = {todos: Todo[]};
export type Action =
  { type: 'add', payload: Todo['title'] }
  | { type: 'done', payload: Todo['id'] }
  | { type: 'undone', payload: Todo['id'] }

export const initialState: State = { todos: mock };

export const reducer: Reducer<State, Action> = function(state, action) {
  let targetIndex: number;
  let todo: Todo[] = [];
  switch (action.type) {
    case 'add':
      return { todos: [...state.todos, { id: state.todos.length.toString(), title: action.payload, isDone: false }] }
    case 'done':
      targetIndex = state.todos.findIndex(v => v.id === action.payload);
      if (targetIndex === -1) { return state; }
      todo = state.todos.splice(targetIndex, 1);
      todo[0].isDone = true;
      return { todos: [...state.todos, ...todo] };
    case 'undone':
      targetIndex = state.todos.findIndex(v => v.id === action.payload);
      if (targetIndex === -1) { return state; }
      todo = state.todos.splice(targetIndex, 1);
      todo[0].isDone = false;
      return { todos: [...state.todos, ...todo] };
    default:
      throw new Error();
  }
}